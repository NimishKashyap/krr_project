(async () => {
    const neo4j = require("neo4j-driver");

    const URI = 'neo4j://localhost'
    const USER='neo4j'
    const PASS='password'

    let driver;

    try {
        driver = neo4j.driver(URI, neo4j.auth.basic(USER, PASS))
        const serverInfo = await driver.getServerInfo()

        console.log("CONNECTION ESTABLISHED!");
        console.log(serverInfo);
    } catch(err) {
        console.log(`Connection error\n${err}\nCause: ${err.cause}`);
        await driver.close();
        return
    }

    // list all hostel blocks
    // await listAllHostelBlocks(driver);

    // check hostel of a student
    // await checkHostelNameOfStudent(driver);

    // check hostels of all students
    // await checkHostelOfAllStudents(driver);

    // check parents of one student
    // await checkGuardianOfStudent(driver);

    // check parents of all students
    // await checkGuardianOfAllStudent(driver)

    // check how many children of parents 
    // await checkCountOfStudentFromParents(driver)

    // EXCEPTION 1: Find all students where hostel is not assigned
    // await hostelNotAssigned(driver)

    // Find students and their respective hostel warden with EXCEPTION 2
    // await studentAndWarden(driver)

    // EXCEPTION 2: If warden is not assigned, then default warden will be chief warden
    // await exceptionWarden(driver)

    // List all medical center incharges for each hostel
    // await medicalInchargeHostel(driver)

    // List students and their respective mess
    // await listMessOfStudents(driver)

    // EXCEPTION 3: If mess is not assigned, assign default mess
    // await exceptionMess(driver)

    // Find type of room of students
    // await roomType(driver);

    // EXCEPTION 4: If room-type is not assigned, default to NAC
    // await exceptionRoomtype(driver)

    // Find current schedule according to time
    // await currentTime(driver)

    // Find available janitors
    // await janitors(driver)


    await driver.close();
})()

async function janitors(driver) {
    const currentTime = 900;

    const { records, summary } = await driver.executeQuery(
        'MATCH (janitor:JANITOR)-[:WORKS_DURING]->(t:TIME { name: "Cleaning" }) return janitor, t',
        {},
        { database: "jcomp" }
    )

    console.log(`Available Janitor during: ${currentTime}`);
    for (let record of records) {
        const time = record.get("t")
        const janitor = record.get("janitor")

        const timings = time.properties.timings;

        timings.forEach(element => {
           const new_time = element.split("-")
           const start = new_time[0];
           const end = new_time[1];

           const sNum = Number.parseInt(start)
           const eNum = Number.parseInt(end)

           if (sNum <= currentTime && currentTime <= eNum) {
            console.log(janitor.properties.name);
           }
        });
    }

}

async function currentTime(driver) {
    const currentTime = 900;
    const { records, summary } = await driver.executeQuery(
        'MATCH (t:TIME) return t',
        {},
        { database: "jcomp" }
    )

    console.log("ACTIVE TIMIGS: ")

    for (let record of records) {
        const time = record.get("t")

        const timings = time.properties.timings;

        timings.forEach(element => {
           const new_time = element.split("-")
           const start = new_time[0];
           const end = new_time[1];

           const sNum = Number.parseInt(start)
           const eNum = Number.parseInt(end)

           if (sNum <= currentTime && currentTime <= eNum) {
                console.log("Current Time is: " + time.properties.name);
                console.log("Period: " + time.properties.timings);
           }

        });
    }

}

async function exceptionRoomtype(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (s:STUDENT) WHERE NOT (s)-[:STAYS_AT]->(:HOSTEL_BLOCK) return s',
        {},
        { database: "jcomp" }
    )

    if (records.length == 0) {
        return;
    }

    console.log("BELOW STUDENTS DOES NOT HAVE ROOM TYPE ASSIGNED");
    for (let record of records) {
        const student = record.get("s")

        console.log(student.properties.name);
    }

    console.log("Default Room type assigned: NAC");
}

async function roomType(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (s:STUDENT)-[stay:STAYS_AT]->(h:HOSTEL_BLOCK) return s,h,stay',
        {},
        { database: "jcomp" }
    )

    for (let record of records) {
        const student = record.get("s")
        const hostel = record.get("h")
        const stay = record.get("stay")

        console.log(student.properties.name);
        console.log(stay.properties.type)
    }

    await exceptionRoomtype(driver)
}

async function exceptionMess(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (s:STUDENT) WHERE NOT (s)-[:EATS_AT_MESS]->(:MESS_TYPE) return s',
        {},
        { database: "jcomp" }
    )

    console.log("The below students are not assigned any mess type: ");
    for (let record of records) {
        const student = record.get("s")

        console.log(student.properties.name);
    }

    console.log("\nDefault mess type assigned: VEG");
}

async function listMessOfStudents(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (s:STUDENT), (c:CATERER) WHERE (s)-[:EATS_AT]->(c) return s, c',
        {},
        { database: "jcomp" }
    )

    for (let record of records) {
        const student = record.get("s")
        const caterer = record.get("c")

        console.log(`Student: ${student.properties.name}\tCaterer: ${caterer.properties.name}`);
    }
}

async function medicalInchargeHostel(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (m:MEDICAL), (b:HOSTEL_BLOCK), (n:MEDICAL) WHERE (m)-[:INCHARGE_OF]->(b) AND (n)-[:ASSISTANT_AT]->(b) return m, b, n',
        {},
        { database: "jcomp" }
    )

    for (let record of records) {
        const medical = record.get("m")
        const block = record.get("b")
        const assistant = record.get("n")

        console.log(`Medical Incharge: ${medical.properties.name}\t\Hostel: ${block.properties.name}`);
        console.log(`Medical Assistant: ${medical.properties.name}\t\Hostel: ${block.properties.name}`);
    }
}

async function exceptionWarden(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (student:STUDENT), (warden:FACULTY { designation: "Chief Warden" }) WHERE NOT (student)-[:STAYS_AT]->(:HOSTEL_BLOCK) return student, warden',
        {},
        { database: "jcomp" }
    )

    for (let record of records) {
        const student = record.get("student")
        const warden = record.get("warden")

        console.log(`Student Name: ${student.properties.name}\t\tWarden: ${warden.properties.name}`);
    }
}



async function studentAndWarden(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (student:STUDENT)-[:STAYS_AT]->(hostel:HOSTEL_BLOCK) OPTIONAL MATCH (warden:FACULTY)-[:WARDEN_OF]->(hostel) RETURN student, warden, hostel',
        {},
        { database: "jcomp" }
    )

    for (let record of records) {
        const student = record.get("student")
        const warden = record.get("warden")
        const hostel = record.get("hostel")
        if (warden.properties.designation == "Warden" ) {
            console.log(student.properties.name);
            console.log(warden.properties.name + "\tHostel Block: " + hostel.properties.name);
            console.log()
        }
    }

    await exceptionWarden(driver)
}

async function hostelNotAssigned(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (student:STUDENT) WHERE NOT (student)-[:STAYS_AT]->(:HOSTEL_BLOCK) return student',
        {},
        { database: "jcomp" }
    )

    if (records.length == 0) {
        console.log("All students have hostel assigned!");
        return;
    }
    console.log("These following students do not have assigned hostels. ");

    for (let record of records) {
        const student = record.get("student")
        console.log("Student details: ");
        console.log(student.properties.name + "\t" + student.properties.regno);

        if (student.properties.gender == "Female") {
            console.log(`Default Hostel block for ${student.properties.name} ====> B`)
        } else {
            console.log(`Default Hostel block for ${student.properties.name} ====> A`)
        }
        console.log()
    }
}

async function checkCountOfStudentFromParents(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (student:STUDENT) <-[:PARENT_OF]-(guardian:GUARDIAN) return count(student) as count, guardian',
        {},
        { database: "jcomp" }
    )

    for (let record of records) {
        const studentCount = record.get("count")
        const hostel = record.get("guardian")

        console.log(`Parent name: ${hostel.properties.name}\t\t Count: ${studentCount.low}\n`)
    }
}

async function checkGuardianOfAllStudent(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (student:STUDENT) <-[:PARENT_OF]-(guardian:GUARDIAN) return student, guardian',
        {},
        { database: "jcomp" }
    )

    for (let record of records) {
        const student = record.get("student")
        console.log(`Student name: ${student.properties.name}`)

        const hostel = record.get("guardian")
        console.log(`Parent is: ${hostel.properties.name}\n`)
    }
}

async function checkGuardianOfStudent(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (student:STUDENT { name: "Nimish Kashyap" }) <-[:PARENT_OF]-(guardian:GUARDIAN) return student, guardian',
        {},
        { database: "jcomp" }
    )

    for (let record of records) {
        const student = record.get("student")
        console.log(`Student name: ${student.properties.name}`)

        const hostel = record.get("guardian")
        console.log(`Parent is: ${hostel.properties.name}\n`)
    }
}

async function checkHostelOfAllStudents(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (student:STUDENT) -[stay:STAYS_AT]->(hostel:HOSTEL_BLOCK) return student, hostel',
        {},
        { database: "jcomp" }
    )

    for (let record of records) {
        const student = record.get("student")
        console.log(`Student name: ${student.properties.name}`)

        const hostel = record.get("hostel")
        console.log(`Student stays at: ${hostel.properties.name}\n`)
    }
}

async function checkHostelNameOfStudent(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (student:STUDENT { name: "Nimish Kashyap" }) -[stay:STAYS_AT]->(hostel:HOSTEL_BLOCK) return student, hostel',
        {},
        { database: "jcomp" }
    )

    for (let record of records) {
        const student = record.get("student")
        console.log(`Student name: ${student.properties.name}`)

        const hostel = record.get("hostel")
        console.log(`Student stays at: ${hostel.properties.name}`)
    }
}

async function listAllHostelBlocks(driver) {
    const { records, summary } = await driver.executeQuery(
        'MATCH (n:HOSTEL_BLOCK) RETURN n',
        {},
        { database: "jcomp" }
    )

    for (let record of records) {
        console.log(record.get("n").properties.name);
    }
}