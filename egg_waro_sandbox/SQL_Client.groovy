
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

sql.execute("DROP TABLE IF EXISTS player")

sql.execute("""
CREATE TABLE player( player_id bigint NOT NULL,
username VARCHAR(256) NOT NULL,
strategy VARCHAR(256) NOT NULL,
num_games integer,
num_wins integer
);
""")

// ----------------------------------
// populate

def insert = " INSERT INTO player (player_id, username, strategy, num_games, num_wins) VALUES (?,?,?,?,?); "

sql.execute insert, [11, 'Bach',   'max_card', 0, 0]
sql.execute insert, [22, 'Chopin', 'min_card', 0,0]
sql.execute insert, [33, 'Mozart', 'max_card', 0,0]
sql.execute insert, [44, 'Liszt',  'random', 0,0]

// ----------------------------------
// query

sql.eachRow("SELECT * FROM player") { row ->
    def builder = new StringBuilder()

    builder.append(" player_id: ${row.player_id}")
    builder.append(" username: ${row.username}")
    builder.append(" strategy: ${row.strategy}" )
    builder.append(" num_games: ${row.num_games}" )
    builder.append(" num_wins: ${row.num_wins}" )

    println builder.toString()
}

sql.close()
println "Ready."

