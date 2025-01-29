
@Grapes(
    @Grab(group='org.postgresql', module='postgresql', version='42.6.0')
)
@GrabConfig(systemClassLoader=true)

import groovy.sql.*
import org.postgresql.*

// ------------------------------
// child_N table

def str = { s -> s as String }

def deleteFromSubscription = { sql ->
    println "TRACER before: " + new Date().toString()
    sql.execute("""
DELETE FROM subscription WHERE status = 'new'
    """)
    println "TRACER after: " + new Date().toString()
}

// ------------------------------
// main

def sql = Sql.newInstance("jdbc:postgresql://127.0.0.1:5432/sandbox", "postgres","CHANGE_ME", "org.postgresql.Driver")

deleteFromSubscription(sql)

sql.close()

