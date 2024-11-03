
@Grapes(
    @Grab(group='org.postgresql', module='postgresql', version='42.6.0')
)
@GrabConfig(systemClassLoader=true)

import groovy.sql.*
import org.postgresql.*

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

sql.execute("""
CREATE TABLE nov_sandbox ( id bigint NOT NULL,
name VARCHAR(256) NOT NULL,
data JSONB
);
ALTER TABLE nov_sandbox ADD PRIMARY KEY (id);
""")

sql.close()

