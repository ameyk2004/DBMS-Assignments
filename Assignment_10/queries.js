// How many Users are active ??

db.users.aggregate(
    {
        '$match' : {
            isActive: true
        }
    },
    {
        '$count' : 'activeUsers'
    }
);

// What is the average age of all users

db.users.aggregate([
    {
        '$group' : {
            '_id' : null,
            average: {
                '$avg' : '$age'
            }
        }
    }
]);

// find the most common favourite fruits

db.users.aggregate([
    {
        '$group' : {
            _id: '$favoriteFruit',
            couuntUsers: 
                {'$sum' : 1}
            
        },
        
    },
    {
        '$sort': {'countUsers' : -1}
    },
    {
        '$limit' : 1
    }
]);


//Find total Number of males and females

db.users.aggregate([
    {
        "$group" : {
           _id: "$gender",
           count: {
            "$sum" : 1
           }
        }
    }
]);

//Which country has highest no. of registered users ?

db.users.find(
    {
        "company.location.country" : {
            "$eq" : "France"
        }
    }
)

db.users.aggregate([
    {
        '$group' : {
            '_id': '$company.location.country',
            registeredUsers: {
                '$sum': 1
            }
        },
    },
    {
        '$sort': {
            'registeredUsers': -1
        }
    },
    {
        '$limit' : 1
    }
])

//List all unique Eye colors present in collection

db.users.aggregate([
    {
        '$group': {
            '_id': '$eyeColor'
        }
    }
])

//Find average number of Tags per User

db.users.aggregate([
    {
        '$unwind': '$tags'
    },
    {
        '$group': {
            '_id': '$name',
            tagCount: {
                '$sum' : 1
            },
        }
    },
    {
        '$group': {
            '_id': null,
            tagAverage: {
                '$avg' : '$tagCount'
            },
        }
    }
])


//How many users have 'enim' has one of their tag

db.users.aggregate([
    {
        '$match' : {
            tags: 'enim'
        }
    }, 
    {
        '$count' : 'userCount'
    }
])

// Find all users who has velit 

db.users.aggregate([
    {
        '$match' : {
            tags: 'consequat',
            isActive: false
        }
    }, 
    {
       '$project': {
        name: 1,
        age: 1
       }
    }
])

