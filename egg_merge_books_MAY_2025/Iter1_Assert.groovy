
@Grapes(
    @Grab(group='org.postgresql', module='postgresql', version='42.6.0')
)
@GrabConfig(systemClassLoader=true)

import groovy.sql.*
import org.postgresql.*

class Book {
    def title
    def author
    def version
}

def getBooks = { sql ->
    def books = []
    sql.eachRow("SELECT title, author, version FROM book") { row ->
        books << new Book(title: row.title, author: row.author, version: row.version)
    }
    return books
}

def assertBooks = { expectedBooks, sql ->
    def actualBooks = getBooks(sql)
    assert expectedBooks.size() == actualBooks.size()

    expectedBooks.each { expectedBook ->
        def actualBook = actualBooks.find { it.title == expectedBook.title }
        assert actualBook
        assert expectedBook.author == actualBook.author
        assert expectedBook.version == actualBook.version
    }
}

class Location {
    def address
    def city
    def province
    def version
}

def getLocations = { sql ->
    def locations = []

    sql.eachRow("SELECT address, city, province, version FROM location") { row ->
        locations << new Location(address: row.address,
                                  city: row.city,
                                  province: row.province, 
                                  version: row.version)
    }

    return locations
}

def assertLocations = { expectedLocations, sql ->
    def actualLocations = getLocations(sql)
    assert expectedLocations.size() == actualLocations.size()

    expectedLocations.each { expectedLocation ->
        def actualLocation = actualLocations.find { it.address == expectedLocation.address }
        assert actualLocation
        assert expectedLocation.city == actualLocation.city
        assert expectedLocation.province == actualLocation.province
        assert expectedLocation.version == actualLocation.version
    }
}

// ------------------------
// main

def MY_DB = System.getenv("MY_DB")
def PASSWORD = System.getenv("PGPASSWORD")

assert MY_DB
assert PASSWORD

def sql = Sql.newInstance("jdbc:postgresql://127.0.0.1:5432/$MY_DB", "postgres", PASSWORD, "org.postgresql.Driver")

try {
    // ----------------------
    // books
    def expectedBooks = []
    expectedBooks << new Book(title: "The Undoing Project", author: "Michael Lewis", version: 1)
    expectedBooks << new Book(title: "What The Dog Saw", author: "Malcolm Gladwell", version: 1)
    expectedBooks << new Book(title: "Master Of The Senate", author: "Robert Caro", version: 1)

    assertBooks(expectedBooks, sql)

    // ----------------------
    // locations
    def expectedLocations = []
    expectedLocations << new Location(address:'5150 Longworth Ave', city:'Charlottetown', province:'PE', version: 1);
    expectedLocations << new Location(address:'6160 Main St', city:'Moncton', province:'NB', version: 1);
    expectedLocations << new Location(address:'7170 Robie St', city:'Halifax', province:'NS', version: 1);
    expectedLocations << new Location(address:'8180 King St', city:'Waterloo', province:'ON', version: 1);

    assertLocations(expectedLocations, sql)

    println "TRACER OK."
} catch (Exception e) {
    System.err.println "TRACER exception: ${e.message}"
} finally {
    sql.close()
}
