
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
DROP TABLE IF EXISTS strategy;
DROP SEQUENCE IF EXISTS strategy_seq;

DROP TABLE IF EXISTS player;
DROP SEQUENCE IF EXISTS player_seq;
""")

// ----------------------------------
// create

sql.execute("""
CREATE TABLE strategy(
id bigint NOT NULL,
name VARCHAR(256) NOT NULL,
constraint pk_strategy primary key (id)
);

CREATE sequence strategy_seq start with 5150;

CREATE TABLE player(
id bigint NOT NULL,
username VARCHAR(256) NOT NULL,
constraint pk_player primary key (id)
);

CREATE sequence player_seq start with 100;
""")

// ----------------------------------
// populate

def insert = ""

insert = " INSERT INTO strategy (id, name) VALUES (nextval('strategy_seq'),?); "

sql.execute insert, ['max_card']
sql.execute insert, ['min_card']
sql.execute insert, ['nearest_card']
sql.execute insert, ['next_card']

insert = " INSERT INTO player (id, username) VALUES (nextval('player_seq'),?); "

sql.execute insert, ['Bach']
sql.execute insert, ['Chopin']
sql.execute insert, ['Mozart']
sql.execute insert, ['Liszt']

// ----------------------------------
// query

println "\nstrategy:"

sql.eachRow("SELECT * FROM strategy") { row ->
    def builder = new StringBuilder()

    builder.append(" id: ${row.id}")
    builder.append(" name: ${row.name}")

    println builder.toString()
}

println "\nplayer:"

sql.eachRow("SELECT * FROM player") { row ->
    def builder = new StringBuilder()

    builder.append(" id: ${row.id}")
    builder.append(" username: ${row.username}")

    println builder.toString()
}

sql.close()
println "Ready."

