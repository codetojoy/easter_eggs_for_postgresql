
@Grapes(
    @Grab(group='org.postgresql', module='postgresql', version='42.6.0')
)
@GrabConfig(systemClassLoader=true)

import groovy.sql.*
import org.postgresql.*


// ------------------------
// main

def text = new File("lorem-ipsum.txt").getText()

def MY_DB = System.getenv("MY_DB")
def PASSWORD = System.getenv("PGPASSWORD")

assert MY_DB
assert PASSWORD

def sql = Sql.newInstance("jdbc:postgresql://127.0.0.1:5432/$MY_DB", "postgres", PASSWORD, "org.postgresql.Driver")

try {
    // ----------------------
    // books

sql.withBatch(100, """
INSERT INTO book
(title, author, excerpt, deleted)
VALUES
(:title, :author, :excerpt, :deleted)
""") { ps ->                 
    def isDone = false
    def max = 10_000 
    def count = 0

    while (!isDone) {
        def title = "Title-${count}"
        def author = "Author-${count}"
        def excerpt = text
        def deleted = (count % 2 == 0)

        ps.addBatch(title:title as String, 
                    author:author as String, 
                    excerpt:excerpt as String,
                    deleted:deleted as Boolean)

        count++
        isDone = count >= max
    }
}

    println "TRACER OK."
} catch (Exception e) {
    System.err.println "TRACER exception: ${e.message}"
} finally {
    sql.close()
}
