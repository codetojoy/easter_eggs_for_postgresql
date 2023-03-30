
@Grapes(
    @Grab(group='org.postgresql', module='postgresql', version='42.6.0')
)
@GrabConfig(systemClassLoader=true)

import groovy.sql.Sql

def host = "127.0.0.1"
def port = 5432
def db = "sandbox"
def user = "postgres"
def password = "swordfish"
def url = "jdbc:postgresql://${host}:${port}/${db}"
def driver = "org.postgresql.Driver"

def sql = Sql.newInstance(url, user, password, driver)

// ----------------------------------
// clean

sql.execute("""
SET CONSTRAINTS ALL DEFERRED;

DROP TABLE IF EXISTS foo;
DROP TABLE IF EXISTS bar;

DROP SEQUENCE IF EXISTS foo_seq;
DROP SEQUENCE IF EXISTS bar_seq;

SET CONSTRAINTS ALL IMMEDIATE;
""")

// ----------------------------------
// create

sql.execute("""
CREATE TABLE foo(
id bigint NOT NULL,
name VARCHAR(256) NOT NULL UNIQUE,
colour VARCHAR(256) UNIQUE,
constraint pk_foo primary key (id)
);

CREATE sequence foo_seq start with 5150;

CREATE TABLE bar(
id bigint NOT NULL,
location VARCHAR(256) NOT NULL UNIQUE,
colour VARCHAR(256) UNIQUE,
constraint pk_bar primary key (id)
);

CREATE sequence bar_seq start with 6160;
""")

// ----------------------------------
// populate

def insert = ""

insert = " INSERT INTO foo (id, name, colour) VALUES (nextval('foo_seq'),?,?); "

sql.execute insert, ['mozart', 'red']
sql.execute insert, ['brahms', 'green']
sql.execute insert, ['paganini', 'silver']

insert = " INSERT INTO foo (id, name) VALUES (nextval('foo_seq'),?); "

sql.execute insert, ['chopin']
sql.execute insert, ['liszt']

insert = " INSERT INTO bar (id, location, colour) VALUES (nextval('bar_seq'),?,?); "

sql.execute insert, ['paris', 'red']
sql.execute insert, ['new york', 'green']
sql.execute insert, ['montreal', 'brown']

insert = " INSERT INTO bar (id, location) VALUES (nextval('bar_seq'),?); "

sql.execute insert, ['london']
sql.execute insert, ['tokyo']

// ----------------------------------
// query

println "\nfoo:"

sql.eachRow("SELECT * FROM foo") { row ->
    def builder = new StringBuilder()

    builder.append(" id: ${row.id}")
    builder.append(" name: ${row.name}")
    builder.append(" colour: ${row.colour}")

    println builder.toString()
}

println "\nbar:"

sql.eachRow("SELECT * FROM bar") { row ->
    def builder = new StringBuilder()

    builder.append(" id: ${row.id}")
    builder.append(" location: ${row.location}")
    builder.append(" colour: ${row.colour}")

    println builder.toString()
}

sql.close()
println "Ready."

