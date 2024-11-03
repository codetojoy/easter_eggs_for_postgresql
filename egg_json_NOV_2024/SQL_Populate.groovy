
@Grapes(
    @Grab(group='org.postgresql', module='postgresql', version='42.6.0')
)
@GrabConfig(systemClassLoader=true)

import groovy.sql.*
import org.postgresql.*
import groovy.json.*

def myGetEnv = { envVar ->
    def result = System.getenv(envVar)
    assert result
    assert !result.isEmpty()
    return result
}

final String DB_NAME = myGetEnv("DB_NAME")
final String DB_USERNAME = myGetEnv("DB_USERNAME")
final String DB_PASSWORD = myGetEnv("DB_PASSWORD")

def user = DB_USERNAME
def password = DB_PASSWORD
def host = "127.0.0.1"
def port = 5432
def database = DB_NAME

def sql = Sql.newInstance("jdbc:postgresql://${host}:${port}/${database}", user, password, "org.postgresql.Driver")

// nov_sandbox

def myInsert(def sql, def id, def data) {
    String name = "name-" + id

    // roster
    def insert = " INSERT INTO nov_sandbox (id, name, data) VALUES (?,?,?::jsonb); "
    sql.execute(insert, [id, name, data])
}

def id

id = 5150
def info = [1,2,3,4]
def json = JsonOutput.toJson(info)
myInsert(sql, id++, json)

sql.close()
