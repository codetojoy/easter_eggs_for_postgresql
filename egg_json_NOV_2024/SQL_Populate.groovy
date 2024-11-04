
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

def buildJson() {
    def info
    def mode = 5

    // see https://www.postgresql.org/docs/15/functions-json.html

    if (mode == 1) {
        info = [1,2,3,4,5]
        // sql: select data->0 from nov_sandbox;
        // sql: select data->-1 from nov_sandbox;
    } else if (mode == 2) {
        info = ["name": "Wolfgang Mozart"]
        // sql: select data->'name' from nov_sandbox;
        // NOTE: ->> converts to text
    } else if (mode == 3) {
        def p1 = ["name": "Wolfgang Mozart"]
        def p2 = ["name": "Frederic Chopin"]
        def p3 = ["name": "Johannes Brahms"]
        info = [p1, p2, p3]
        // sql: select data->'name' from nov_sandbox;
        // NOTE: ->> converts to text
    } else if (mode == 4) {
        def p1 = ["name": "Wolfgang Mozart", works:["wm1","wm2","wm3"]]
        def p2 = ["name": "Frederic Chopin", works:["fc1","fc2","fc3"]]
        def p3 = ["name": "Johannes Brahms", works:["jb1","jb2","jb3"]]
        info = [p1, p2, p3]
        // sql: select data #> '{1, works, 0}' from nov_sandbox; 
        // "fc1"
    } else if (mode == 5) {
        def p1 = ["name": "Wolfgang Mozart", works:["wm1","wm2","wm3"]]
        info = p1
        // sql: select data @> '{"name": "Wolfgang Mozart"}' from nov_sandbox;
        // true 
    }

    return JsonOutput.toJson(info)
}

def id

id = 5150
myInsert(sql, id++, buildJson())

sql.close()
