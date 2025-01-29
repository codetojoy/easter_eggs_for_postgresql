
@Grapes(
    @Grab(group='org.postgresql', module='postgresql', version='42.6.0')
)
@GrabConfig(systemClassLoader=true)

import groovy.sql.*
import org.postgresql.*

class ChildInfo {
    def name
    def id
}

// ------------------------------
// child_N table

def str = { s -> s as String }

def dropAll = { sql ->
    sql.execute("DROP TABLE IF EXISTS subscription")
    sql.execute("DROP TABLE IF EXISTS child_1")
    sql.execute("DROP TABLE IF EXISTS child_2")
    sql.execute("DROP TABLE IF EXISTS child_3")
    sql.execute("DROP TABLE IF EXISTS child_4")
    sql.execute("DROP TABLE IF EXISTS child_5")
    sql.execute("DROP TABLE IF EXISTS child_6")
    sql.execute("DROP TABLE IF EXISTS child_7")
    sql.execute("DROP TABLE IF EXISTS child_8")
}

def populateSubscription = { sql, numRecs, map ->

    sql.execute("""
    CREATE TABLE subscription ( 
    id UUID NOT NULL,
    name VARCHAR(256) NOT NULL,
    status VARCHAR(256),
    child_1_id UUID,
    child_2_id UUID,
    child_3_id UUID,
    child_4_id UUID,
    child_5_id UUID,
    child_6_id UUID,
    child_7_id UUID,
    child_8_id UUID
    );

ALTER TABLE subscription ADD FOREIGN KEY(child_1_id) REFERENCES child_1(id);
ALTER TABLE subscription ADD FOREIGN KEY(child_2_id) REFERENCES child_2(id);
ALTER TABLE subscription ADD FOREIGN KEY(child_3_id) REFERENCES child_3(id);
ALTER TABLE subscription ADD FOREIGN KEY(child_4_id) REFERENCES child_4(id);
ALTER TABLE subscription ADD FOREIGN KEY(child_5_id) REFERENCES child_5(id);
ALTER TABLE subscription ADD FOREIGN KEY(child_6_id) REFERENCES child_6(id);
ALTER TABLE subscription ADD FOREIGN KEY(child_7_id) REFERENCES child_7(id);
ALTER TABLE subscription ADD FOREIGN KEY(child_8_id) REFERENCES child_8(id);
    """)

    sql.withBatch { stmt ->
        numRecs.times { i ->
            def id = UUID.randomUUID() 
            def name = str("name_${i}")
            def status = 'new'
            def uuid1 = map["name_1_${i}"]
            def uuid2 = map["name_2_${i}"]
            def uuid3 = map["name_3_${i}"]
            def uuid4 = map["name_4_${i}"]
            def uuid5 = map["name_5_${i}"]
            def uuid6 = map["name_6_${i}"]
            def uuid7 = map["name_7_${i}"]
            def uuid8 = map["name_8_${i}"]

            def insert = """
INSERT INTO subscription 
(id, name, status, child_1_id, child_2_id, child_3_id, child_4_id,
child_5_id, child_6_id, child_7_id, child_8_id) 
VALUES (
'${id}','${name}','${status}',
'${uuid1}','${uuid2}','${uuid3}','${uuid4}',
'${uuid5}','${uuid6}','${uuid7}','${uuid8}'
);
""" as String
            stmt.addBatch(insert)
        }
    }
}

def buildMegaMap = { sql ->
    def map = [:]

    for (int i = 1; i <= 8; i++) {
        String tableName = str("child_${i}")
        sql.eachRow(str("SELECT id, name FROM ${tableName}")) { row ->
            map[row.name] = row.id
        }
    }

    return map
}

def populateChild = { sql, tableN, numRecs ->
    String tableName = str("child_${tableN}")

    sql.execute("""
    CREATE TABLE ${tableName}( 
    id UUID PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    status VARCHAR(256)
    );
    """ as String)

    sql.withBatch { stmt ->
        numRecs.times { i ->
            def id = UUID.randomUUID() 
            def name = str("name_${tableN}_${i}")
            def status = 'new'
            def insert = str("INSERT INTO ${tableName} (id, name, status) VALUES ('${id}','${name}','${status}');") 
            stmt.addBatch(insert)
        }
    }

/*
    sql.eachRow(str("SELECT id, name, status FROM ${tableName}")) { row ->
        println "table: ${tableName} id: ${row.id} name: ${row.name} status: ${row.status}"
    }
*/
}

// ------------------------------
// main

def sql = Sql.newInstance("jdbc:postgresql://127.0.0.1:5432/sandbox", "postgres","CHANGE_ME", "org.postgresql.Driver")

dropAll(sql)

def numRecs = 100_000

populateChild(sql, 1, numRecs)
populateChild(sql, 2, numRecs)
populateChild(sql, 3, numRecs)
populateChild(sql, 4, numRecs)
populateChild(sql, 5, numRecs)
populateChild(sql, 6, numRecs)
populateChild(sql, 7, numRecs)
populateChild(sql, 8, numRecs)

def map = buildMegaMap(sql) 

populateSubscription(sql, numRecs, map)

sql.close()

