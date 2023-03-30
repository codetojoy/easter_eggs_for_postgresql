
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

DROP TABLE IF EXISTS config;
DROP TABLE IF EXISTS player_stats;

DROP TABLE IF EXISTS player;
DROP SEQUENCE IF EXISTS player_seq;

DROP TABLE IF EXISTS strategy;
DROP SEQUENCE IF EXISTS strategy_seq;

SET CONSTRAINTS ALL IMMEDIATE;
""")

// ----------------------------------
// create

sql.execute("""
CREATE TABLE config(
numCards bigint NOT NULL
);

CREATE TABLE strategy(
id bigint NOT NULL,
name VARCHAR(256) NOT NULL UNIQUE,
constraint pk_strategy primary key (id)
);

CREATE sequence strategy_seq start with 5150;

CREATE TABLE player(
id bigint NOT NULL,
username VARCHAR(256) NOT NULL UNIQUE,
strategy_id bigint NOT NULL,
active boolean,
constraint pk_player primary key (id)
);

CREATE sequence player_seq start with 100;

ALTER TABLE player
    add constraint fk_player_strategy
    foreign key (strategy_id)
    REFERENCES strategy (id);

CREATE TABLE player_stats(
player_id bigint NOT NULL,
num_total_games bigint NOT NULL,
num_total_wins bigint NOT NULL
);

ALTER TABLE player_stats
    add constraint fk_player_stats_player
    foreign key (player_id)
    REFERENCES player (id);
""")

// ----------------------------------
// populate

def insert = ""

insert = " INSERT INTO strategy (id, name) VALUES (nextval('strategy_seq'),?); "

sql.execute insert, ['max_card']
sql.execute insert, ['min_card']
sql.execute insert, ['nearest_card']
sql.execute insert, ['next_card']

insert = """
INSERT INTO player (id, username, strategy_id, active)
VALUES (nextval('player_seq'),?,(SELECT id from strategy where name = ?),?);
"""

sql.execute insert, ['Bach', 'max_card', true]
sql.execute insert, ['Chopin', 'min_card', true]
sql.execute insert, ['Mozart', 'nearest_card', true]
sql.execute insert, ['Liszt', 'next_card', true]

insert = """
INSERT INTO player_stats (player_id, num_total_games, num_total_wins)
VALUES ((SELECT id from player where username = ?),?,?);
"""

sql.execute insert, ['Bach', 3, 0]
sql.execute insert, ['Chopin', 4, 1]
sql.execute insert, ['Mozart', 5, 0]
sql.execute insert, ['Liszt', 6, 2]

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

sql.eachRow(
"""
SELECT p.id, p.username, s.name, p.active, ps.num_total_wins, ps.num_total_games FROM player p
JOIN strategy s ON p.strategy_id = s.id
JOIN player_stats ps ON ps.player_id = p.id
""") { row ->
    def builder = new StringBuilder()

    builder.append(" id: ${row.id}")
    builder.append(" username: ${row.username}")
    builder.append(" strategy: ${row.name}")
    builder.append(" active: ${row.active}")
    builder.append(" # wins: ${row.num_total_wins}")
    builder.append(" # games: ${row.num_total_games}")

    println builder.toString()
}

sql.close()
println "Ready."

