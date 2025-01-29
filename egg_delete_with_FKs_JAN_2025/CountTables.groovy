
@Grapes(
    @Grab(group='org.postgresql', module='postgresql', version='42.6.0')
)
@GrabConfig(systemClassLoader=true)

import groovy.sql.*
import org.postgresql.*

// ------------------------------
// count table

def str = { s -> s as String }

def countRows = { sql, table ->
    sql.eachRow(str("SELECT count(*) as numRecs FROM ${table}")) { row ->
        println "table: ${table} count: ${row.numRecs}"
    }
}

// ------------------------------
// main

def sql = Sql.newInstance("jdbc:postgresql://127.0.0.1:5432/sandbox", "postgres","CHANGE_ME", "org.postgresql.Driver")

countRows(sql, "child_1")
countRows(sql, "child_2")
countRows(sql, "child_3")
countRows(sql, "child_4")
countRows(sql, "child_5")
countRows(sql, "child_6")
countRows(sql, "child_7")
countRows(sql, "child_8")

countRows(sql, "subscription")

sql.close()

