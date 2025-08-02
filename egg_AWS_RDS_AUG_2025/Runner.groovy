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

    sql.eachRow("SELECT version() AS v") { row ->
        println row.v
    }
} catch (Exception ex) {
    System.err.println "caught exception: " + ex.message
} finally {
    sql.close()
}

