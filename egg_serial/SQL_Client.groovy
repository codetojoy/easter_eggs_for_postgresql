
@Grapes(
    @Grab(group='org.postgresql', module='postgresql', version='42.6.0')
)
@GrabConfig(systemClassLoader=true)

import groovy.sql.*
import org.postgresql.*

def sql = Sql.newInstance("jdbc:postgresql://127.0.0.1:5432/sandbox", "postgres","swordfish", "org.postgresql.Driver")

sql.execute("DROP TABLE IF EXISTS account")

sql.execute("""
CREATE TABLE account( 
account_id SERIAL,
username VARCHAR(256) NOT NULL,
status VARCHAR(256)
);
""")

def insert = " INSERT INTO account (username, status) VALUES (?,?); "

sql.execute(insert, ['James_Bond',     'active']);
sql.execute(insert, ['Jason_Bourne',   'cancel'])
sql.execute insert, ['Emily_Pollifax', 'cancel']
sql.execute insert, ['Maxwell_Smart',  'block']
sql.execute insert, ['Jaime_Sommers',  'active']
sql.execute insert, ['Blanche_White',  'active']

sql.eachRow("SELECT account_id, username, status FROM account") { row ->
    println "account_id: ${row.account_id} username: ${row.username} status: ${row.status}"
}

sql.close()

