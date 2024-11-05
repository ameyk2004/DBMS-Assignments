/*
Create a MongoDB collection and insert every variety of documents

teachers : {
    name,
    age,
    qualifications,
    deptno,
    deptname,
    designation,
    experience : {
        industry,
        teaching
    },
    salary : {
        basic,
        TA,
        DA,
        HRA
    },
    date_of_joining,
    appointment_nature,
    area_of_expertise
}

*/

// CREATION

db.createCollection("teacher")

db.teacher.insertMany([
    {
        name: "Vijayendra Gaikwad",
        age: 27,
        qualifications: ["MTech", "Phd"],
        deptno: 1,
        deptname: "CSE",
        designation: "Assistant Professor",
        experience: {
            industry: 5,
            teaching: 3
        },
        salary : {
            basic: 50000,
            TA: 10000,
            DA: 20000,
            HRA: 15000
        },
        date_of_joining : new Date("2024-09-24"),
        appointment_nature: "Permanent",
        area_of_expertise: ["DBMS", "AIML"]
    }
])


// INSERTIONS



// QUERIES

/*
8. Use save() method to insert one entry in teachers collection
9. Useupdate() method to change the designation of teachers whose experience is 10 yearsor above to Professor
10. Use save() method to change the designation of teachers to Professor.
11. Delete the documents from teachers collection having appointment_natureas “adhoc”.
12. Display with pretty() method, the first 3 documents in teachers collection in ascending orderof experience
*/

// Find the information about all teachers
db.teacher.find()

// Find the information about all teachers of computer department
db.teacher.find({deptname : {$eq : 'CSE'}})

// Find the information about all teachersof CSE, IT & FE departments
db.teacher.find({deptname : {$in : ['CSE', 'IT', 'FE']}})

// Find the information about all teachers of computer, IT and E&TC department having salary in between 70,000 and 1,00,000 (inclusive)
db.teacher.find({
    deptname: {$in : ["CSE", 'IT', "FE"]},
    $and : [
        {"salary.basic" : {$lte : 100000}},
        {"salary.basic" : {$gte : 70000}},
    ]
})

// Update the experience of any teacher to 10 years and if the entry is not available in database consider the entry as new entry (use update function only)

db.teacher.updateOne(
    {name : "Vijayendra Gaikwad"},
    {$set : {"experience.teaching" : 10}},
    {upsert : true}
)

db.teacher.updateOne(
    {name : "Amey Kulkarni"},
    {$set : {"experience.teaching" : 10}},
    {upsert : true}
)

// Find the teachers‟ name and experience & arrange in decreasing order of experience