
// Assiggment 10 : 
// MongoDB Aggregation and Indexing: 

// Design and Develop MongoDB Queries using aggregation and
// indexing with suitable example using MongoDB

// Collection : orders

//  {
//     "product":"toothbrush",
//     "price":21,
//     "customer":"Amey"
//  }

db.createCollection("orders");

db.orders.insertMany([
    {
        "product": "toothbrush",
        "price": 21,
        "customer": "Ayush"
    },
    {
        "product": "toothbrush",
        "price": 21,
        "customer": "Durvesh"
    },
    {
        "product": "pizza",
        "price": 130,
        "customer": "Kushal"
    },
    {
        "product": "pizza",
        "price": 130,
        "customer": "Ayush"
    },
    {
        "product": "tea",
        "price": 20,
        "customer": "Karan"
    },
    {
        "product": "tea",
        "price": 20,
        "customer": "Yash"
    }
]);


// Find out How mant toothbrushes were sold

db.orders.aggregate([
    {
        "$match" : {
            product: "toothbrush"
        }
    },
    {
        "$count": 'no_of_tooth_brushes'
    }
]);

// Find the list of all sold products

db.orders.aggregate([
    {
        "$group" : {
            _id : "$product",
            count: {
                "$sum" : 1
            }
        }
    }
])

// Find the total amount of money spent by each customer

db.orders.aggregate([
    {
        "$group": {
            _id: "$customer",
            moneySpent: {
                "$sum": "$price"
            }
        }
    }
])

// Find how much has been spent on each product and sort it by amount spent

db.orders.aggregate([
    {
        "$group" : {
            _id: "$product",
            amount_spent: {
                "$sum" : "$price"
            }
        }
    },
    {
        "$sort" : {
            "amount_spent" : 1
        }
    }
])

// Find the product with least earnings.

db.orders.aggregate([
    {
        "$group" : {
            _id: "$product",
            amount_spent: {
                "$sum" : "$price"
            }
        }
    },
    {
        "$sort" : {
            "amount_spent" : 1
        }
    },
    {
        "$limit":1
    }
])

// Find how much money each customer has spent on toothbrushes and pizza

db.orders.aggregate([
    {
        "$match" :{
            product : {
                "$in" : ["toothbrush", "pizza"]
            }
        }
    },
    {
        "$group" : {
            _id: "$customer",
            amount_spent: {
                "$sum" : "$price"
            }
        }
    }
]);

// Find the customers who has given highest business for the product toothbrush


db.orders.aggregate([
    {
        "$match" : {
            product: "toothbrush"
        }
    },
    {
        "$group" : {
            _id: "$customer",
            money_spent: {
                "$sum" : "$price"
            }
        }
    },
    {
        "$sort": {
            "money_spent" : -1
        }
    }, 
    {
        "$limit" : 1
    }
]);