// different entities
create (student:STUDENT:PERSON { name: "Nimish Kashyap", regno: "20BRS1049", gender: "Male" }) return student;
create (student:STUDENT:PERSON { name: "Neelabh Kashyap", regno: "20BRS1039", gender: "Male" }) return student;
create (student:PERSON:STUDENT { name: "Dhairya Gupta", regno: "20BRS1077", gender: "Male" }) return student;
create (student:PERSON:STUDENT { name: "Harsh Valambe", regno: "20BRS1197", gender: "Male" }) return student;

create (student:PERSON:STUDENT { name: "New Male Student", regno: "23BRS1111", gender: "Male" }) return student;
create (student:PERSON:STUDENT { name: "New Female Student", regno: "23BRS1111", gender: "Female" }) return student;


create (student:PERSON:STUDENT { name: "Harshita Wang", regno: "20BCE1097", gender: "Female" }) return student;
create (student:PERSON:STUDENT { name: "Prateeksha Mohanty", regno: "21BCE2944", gender: "Female" }) return student;
create (student:PERSON:STUDENT { name: "Ishika Kashyap", regno: "22BRS1034", gender: "Female" }) return student;
create (student:PERSON:STUDENT { name: "Noimisha Das", regno: "19BCS1011", gender: "Female" }) return student;


create (guardian:PERSON:GUARDIAN { name: "Dr. Mridul Sarma" }) return guardian;
create (guardian:PERSON:GUARDIAN { name: "Mr. Nimit Gupta" }) return guardian;
create (guardian:PERSON:GUARDIAN { name: "Mr. Ashok Valambe" }) return guardian;
create (guardian:PERSON:GUARDIAN { name: "Col. S. Wang" }) return guardian;
create (guardian:PERSON:GUARDIAN { name: "Mr. Manas R. Mohanty" }) return guardian;
create (guardian:PERSON:GUARDIAN { name: "Mr. Mukul Sarma" }) return guardian;

match (n:STUDENT { name:"Nimish Kashyap" }) match (m:GUARDIAN { name: "Dr. Mridul Sarma" })
create (m)-[:PARENT_OF]->(n)
create (n)-[:CHILD_OF]->(m);

match (n:STUDENT { name:"Neelabh Kashyap" }) match (m:GUARDIAN { name: "Dr. Mridul Sarma" })
create (m)-[:PARENT_OF]->(n)
create (n)-[:CHILD_OF]->(m);

match (n:STUDENT { name:"Dhairya Gupta" }) match (m:GUARDIAN { name: "Mr. Nimit Gupta" })
create (m)-[:PARENT_OF]->(n)
create (n)-[:CHILD_OF]->(m);

match (n:STUDENT { name:"Harsh Valambe" }) match (m:GUARDIAN { name: "Mr. Ashok Valambe" })
create (m)-[:PARENT_OF]->(n)
create (n)-[:CHILD_OF]->(m);

match (n:STUDENT { name:"Harshita Wang" }) match (m:GUARDIAN { name: "Col. S. Wang" })
create (m)-[:PARENT_OF]->(n)
create (n)-[:CHILD_OF]->(m);

match (n:STUDENT { name:"Prateeksha Mohanty" }) match (m:GUARDIAN { name: "Mr. Manas R. Mohanty" })
create (m)-[:PARENT_OF]->(n)
create (n)-[:CHILD_OF]->(m);

match (n:STUDENT { name:"Ishika Kashyap" }) match (m:GUARDIAN { name: "Mr. Mukul Sarma" })
create (m)-[:PARENT_OF]->(n)
create (n)-[:CHILD_OF]->(m);

match (n:STUDENT { name:"Noimisha Das" }) match (m:GUARDIAN { name: "Mr. Mukul Sarma" })
create (m)-[:PARENT_OF]->(n)
create (n)-[:CHILD_OF]->(m);


// hostel blocks
create (block:HOSTEL_BLOCK:BUILDING { name: "A" }) return block;
create (block:HOSTEL_BLOCK:BUILDING { name: "B" }) return block;
create (block:HOSTEL_BLOCK:BUILDING { name: "C" }) return block;


create (guard:PERSON:STAFF:SECURITY { name: "Mr. Sailen Das", gender: "Male" }) return guard;
create (guard:PERSON:STAFF:SECURITY { name: "Mr. Anup Chauhan", gender: "Male" }) return guard;
create (guard:PERSON:STAFF:SECURITY { name: "Mrs. Smita Roy", gender: "Female" }) return guard;
create (guard:PERSON:STAFF:SECURITY { name: "Mrs. Amirta Kashyap", gender: "Female" }) return guard;


match (n:SECURITY) where n.name = "Mrs. Smita Roy" or n.name="Mrs. Amirta Kashyap" 
match (m:BUILDING { name: "B" })
create (n)-[:GUARDS_AT]->(m);

match (n:SECURITY) where n.name = "Mr. Sailen Das" 
match (m:BUILDING { name: "A" })
create (n)-[:GUARDS_AT]->(m);

match (n:SECURITY) where n.name = "Mr. Anup Chauhan" 
match (m:BUILDING { name: "C" })
create (n)-[:GUARDS_AT]->(m);

// warden
create (warden:PERSON:STAFF:FACULTY { name: "Dr. Amrit Paul", designation: "Warden" }) return warden;
create (warden:PERSON:STAFF:FACULTY { name: "Dr. Shaheen Ahmed", designation: "Warden" }) return warden;
create (warden:PERSON:STAFF:FACULTY { name: "Dr. Omar Waheed", designation: "Warden" }) return warden;

create (chief_warden:PERSON:STAFF:FACULTY { name: "Dr. Milind Srinivas", designation: "Chief Warden" }) return chief_warden;

match (n:STAFF) where n.designation = "Chief Warden"
match (m:HOSTEL_BLOCK)
create (n)-[:WARDEN_OF]->(m);

match (n:STAFF { name: "Dr. Amrit Paul" }) 
match (m:HOSTEL_BLOCK {name: "A" })
create (n)-[:WARDEN_OF]->(m);

match (n:STAFF { name: "Dr. Shaheen Ahmed" }) 
match (m:HOSTEL_BLOCK {name: "B" })
create (n)-[:WARDEN_OF]->(m);

match (n:STAFF { name: "Dr. Omar Waheed" }) 
match (m:HOSTEL_BLOCK {name: "C" })
create (n)-[:WARDEN_OF]->(m);

create (doctor:PERSON:STAFF:MEDICAL { name: "Dr. Rajashekharan M.", designation: "Doctor" }) return doctor;
create (doctor:PERSON:STAFF:MEDICAL { name: "Dr. Lester Rubio", designation: "Doctor" }) return doctor;
create (doctor:PERSON:STAFF:MEDICAL { name: "Dr. George Mathew", designation: "Doctor" }) return doctor;

create (nurse:PERSON:STAFF:MEDICAL { name: "Ms. Ellis Fitzgerald", designation: "Nurse" }) return nurse;
create (nurse:PERSON:STAFF:MEDICAL { name: "Ms. Kimberly Hayes", designation: "Nurse" }) return nurse;
create (nurse:PERSON:STAFF:MEDICAL { name: "Ms. Lilian Jensen", designation: "Nurse" }) return nurse;

create (driver:PERSON:STAFF:MEDICAL { name: "Mr. Lane", designation: "Driver" }) return driver;

match (n:MEDICAL { name: "Dr. Rajashekharan M." }) match (m:HOSTEL_BLOCK { name: "A" })
create (n)-[:INCHARGE_OF]->(m);

match (n:MEDICAL { name: "Dr. Lester Rubio" }) match (m:HOSTEL_BLOCK { name: "B" })
create (n)-[:INCHARGE_OF]->(m);

match (n:MEDICAL { name: "Dr. George Mathew" }) match (m:HOSTEL_BLOCK { name: "C" })
create (n)-[:INCHARGE_OF]->(m);

match (n:MEDICAL { name: "Ms. Ellis Fitzgerald" }) match (m:HOSTEL_BLOCK { name: "A" })
create (n)-[:ASSISTANT_AT]->(m);

match (n:MEDICAL { name: "Ms. Kimberly Hayes" }) match (m:HOSTEL_BLOCK { name: "B" })
create (n)-[:ASSISTANT_AT]->(m);

match (n:MEDICAL { name: "Ms. Lilian Jensen" }) match (m:HOSTEL_BLOCK { name: "C" })
create (n)-[:ASSISTANT_AT]->(m);

match (n:MEDICAL { designation: "Driver" }) match (m:HOSTEL_BLOCK)
create (n)-[:AMBULANCE_DRIVER_FOR]->(m);

//////////////////////////////////////////////////
// create student hostel mappings
match (student:STUDENT { name: "Nimish Kashyap" })
match (block:HOSTEL_BLOCK { name: "A" })
create (student)-[:STAYS_AT { room_number: "845", type: "4 NAC" }]->(block);

match (student:STUDENT { name: "Neelabh Kashyap" })
match (block:HOSTEL_BLOCK { name: "A" })
create (student)-[:STAYS_AT { room_number: "814", type: "3 AC" }]->(block);

match (student:STUDENT { name: "Dhairya Gupta" })
match (block:HOSTEL_BLOCK { name: "A" })
create (student)-[:STAYS_AT { room_number: "845", type: "NAC" }]->(block);

match (student:STUDENT { name: "Harsh Valambe" })
match (block:HOSTEL_BLOCK { name: "C" })
create (student)-[:STAYS_AT { room_number: "420", type: "AC" }]->(block);

match (student:STUDENT { name: "Harshita Wang" })
match (block:HOSTEL_BLOCK { name: "B" })
create (student)-[:STAYS_AT { room_number: "110", type: "AC" }]->(block);

match (student:STUDENT { name: "Prateeksha Mohanty" })
match (block:HOSTEL_BLOCK { name: "B" })
create (student)-[:STAYS_AT { room_number: "617", type: "AC" }]->(block);

match (student:STUDENT { name: "Ishika Kashyap" })
match (block:HOSTEL_BLOCK { name: "B" })
create (student)-[:STAYS_AT { room_number: "845", type: "NAC" }]->(block);

match (student:STUDENT { name: "Noimisha Das" })
match (block:HOSTEL_BLOCK { name: "B" })
create (student)-[:STAYS_AT { room_number: "511", type: "AC" }]->(block);

// types of mess 
create (mess_type_1:MESS_TYPE { name: "VEG" }) return mess_type_1;
create (mess_type_2:MESS_TYPE { name: "NON-VEG" }) return mess_type_2;
create (mess_type_3:MESS_TYPE { name: "SPECIAL" }) return mess_type_3;

//  attach mess with students
match (student:STUDENT { name: "Nimish Kashyap" })
match (mess_type:MESS_TYPE { name: "NON-VEG" })
create (student)-[:EATS_AT_MESS]->(mess_type);

match (student:STUDENT { name: "Neelabh Kashyap" })
match (mess_type:MESS_TYPE { name: "VEG" })
create (student)-[:EATS_AT_MESS]->(mess_type);

match (student:STUDENT { name: "Noimisha Das" })
match (mess_type:MESS_TYPE { name: "SPECIAL" })
create (student)-[:EATS_AT_MESS]->(mess_type);

match (student:STUDENT { name: "Dhairya Gupta" })
match (mess_type:MESS_TYPE { name: "VEG" })
create (student)-[:EATS_AT_MESS]->(mess_type);

match (student:STUDENT { name: "Harsh Valambe" })
match (mess_type:MESS_TYPE { name: "NON-VEG" })
create (student)-[:EATS_AT_MESS]->(mess_type);

match (student:STUDENT { name: "Harshita Wang" })
match (mess_type:MESS_TYPE { name: "SPECIAL" })
create (student)-[:EATS_AT_MESS]->(mess_type);

match (student:STUDENT { name: "Prateeksha Mohanty" })
match (mess_type:MESS_TYPE { name: "NON-VEG" })
create (student)-[:EATS_AT_MESS]->(mess_type);

match (student:STUDENT { name: "Ishika Kashyap" })
match (mess_type:MESS_TYPE { name: "VEG" })
create (student)-[:EATS_AT_MESS]->(mess_type);

// list of caterers
create (caterer:CATERER { name: "FCCL" }) return caterer;
create (caterer:CATERER { name: "RCCL" }) return caterer;

match (student:STUDENT { name: "Ishika Kashyap" })
match (caterer:CATERER { name: "FCCL" })
create (student)-[:EATS_AT]->(caterer);

match (student:STUDENT { name: "Neelabh Kashyap" })
match (caterer:CATERER { name: "FCCL" })
create (student)-[:EATS_AT]->(caterer);

match (student:STUDENT { name: "Nimish Kashyap" })
match (caterer:CATERER { name: "RCCL" })
create (student)-[:EATS_AT]->(caterer);

match (student:STUDENT { name: "Noimisha Das" })
match (caterer:CATERER { name: "RCCL" })
create (student)-[:EATS_AT]->(caterer);

match (student:STUDENT { name: "Dhairya Gupta" })
match (caterer:CATERER { name: "FCCL" })
create (student)-[:EATS_AT]->(caterer);

match (student:STUDENT { name: "Harsh Valambe" })
match (caterer:CATERER { name: "FCCL" })
create (student)-[:EATS_AT]->(caterer);

match (student:STUDENT { name: "Harshita Wang" })
match (caterer:CATERER { name: "RCCL" })
create (student)-[:EATS_AT]->(caterer);

match (student:STUDENT { name: "Prateeksha Mohanty" })
match (caterer:CATERER { name: "FCCL" })
create (student)-[:EATS_AT]->(caterer);

create (librarian:PERSON:STAFF:LIBRARIAN { name: "Mr. S. Raman" }) return librarian;

create (janitor:PERSON:STAFF:JANITOR { name: "Mr. Ali R." }) return janitor;
create (janitor:PERSON:STAFF:JANITOR { name: "Jing S." }) return janitor;
create (janitor:PERSON:STAFF:JANITOR { name: "Sailen Singh" }) return janitor;

match (janitor:JANITOR {name: "Mr. Ali R." })
match (block:HOSTEL_BLOCK { name: "A" })
create (janitor)-[:CLEANS_AT]->(block);

match (janitor:JANITOR {name: "Jing S." })
match (block:HOSTEL_BLOCK { name: "B" })
create (janitor)-[:CLEANS_AT]->(block);

match (janitor:JANITOR {name: "Sailen Singh" })
match (block:HOSTEL_BLOCK { name: "C" })
create (janitor)-[:CLEANS_AT]->(block);

create (electrician:PERSON:STAFF:ELECTRICIAN { name: "Mr. M. Mathuram" }) return electrician;
create (electrician:PERSON:STAFF:ELECTRICIAN { name: "Mr. Albert" }) return electrician;
create (electrician:PERSON:STAFF:ELECTRICIAN { name: "Mr. Robert" }) return electrician;

match (electrician:ELECTRICIAN {name: "Mr. M. Mathuram" })
match (block:HOSTEL_BLOCK { name: "A" })
create (electrician)-[:WORKS_AT]->(block);

match (electrician:ELECTRICIAN {name: "Mr. Albert" })
match (block:HOSTEL_BLOCK { name: "B" })
create (electrician)-[:WORKS_AT]->(block);

match (electrician:ELECTRICIAN {name: "Mr. Robert" })
match (block:HOSTEL_BLOCK { name: "C" })
create (electrician)-[:WORKS_AT]->(block);


// time of day states

create (time:TIME { name: "Breakfast", timings: ["0700-1000"] }) return time;
create (time:TIME { name: "Lunch", timings: ["1200-1400"] }) return time;
create (time:TIME { name: "Dinner", timings: ["1900-2100"] }) return time;

create (time:TIME { name: "Gymnasium", timings: ["1600-1900"] }) return time; 
create (time:TIME { name: "Job Period", timings: ["0700-1100"] }) return time;
create (time:TIME { name: "Cleaning", timings: ["0900-1200"] }) return time;

match (janitor:JANITOR {name: "Sailen Singh" })
match (time:TIME { name: "Cleaning" })
create (janitor)-[:WORKS_DURING]->(time);

match (janitor:JANITOR {name: "Mr. Ali R." })
match (time:TIME { name: "Cleaning" })
create (janitor)-[:WORKS_DURING]->(time);

match (janitor:JANITOR {name: "Jing S." })
match (time:TIME { name: "Cleaning" })
create (janitor)-[:WORKS_DURING]->(time);
