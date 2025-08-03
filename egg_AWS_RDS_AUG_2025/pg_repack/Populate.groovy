@Grapes(
    @Grab(group='org.postgresql', module='postgresql', version='42.6.0')
)
@GrabConfig(systemClassLoader=true)

import groovy.sql.*
import org.postgresql.*

def getEnvValue = { envVar ->
    def result = System.getenv(envVar)
    assert result
    return result
}

def sql = null

try {
    def dbHost = getEnvValue("DB_HOST")
    def dbPort = getEnvValue("DB_PORT")
    def dbName = getEnvValue("DB_NAME")
    def dbUser = getEnvValue("DB_USER")
    def dbPass = getEnvValue("DB_PASS")

    sql = Sql.newInstance("jdbc:postgresql://${dbHost}:${dbPort}/${dbName}", dbUser, dbPass, "org.postgresql.Driver")

    // -------------- main 

    def text = new File("lorem-ipsum.txt").getText().substring(0,20)

    // ----------------------
    // books

    sql.withBatch(100, """
    INSERT INTO book
    (title, author, excerpt, deleted)
    VALUES
    (:title, :author, :excerpt, :deleted)
    """) { ps ->                 
        def isDone = false
        def max = 1000
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
} catch (Exception ex) {
    System.err.println "caught exception: " + ex.message
} finally {
    sql.close()
}


