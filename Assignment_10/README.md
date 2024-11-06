
# MongoDB Aggregation Pipeline - Notes

## 1. **$match** Operator
The `$match` operator is used to filter documents in the pipeline. It works similarly to the `find()` query in MongoDB and passes only the documents that match the specified condition to the next stage.

### Example:
```javascript
db.users.aggregate([
    { '$match': { 'isActive': true } }
])
```
This query filters out documents where `isActive` is `true` and passes only active users to the next stage.

### Key Notes:
- `$match` can filter documents based on any condition (e.g., equality, greater than, less than).
- It is commonly used at the start of an aggregation pipeline to narrow down the dataset.

---

## 2. **$count** Operator
The `$count` operator counts the number of documents that pass through the pipeline and outputs a document containing the count.

### Example:
```javascript
db.users.aggregate([
    { '$match': { 'isActive': true } },
    { '$count': 'activeUsers' }
])
```
This query counts how many users are active.

### Key Notes:
- The result of `$count` is a single document with the field name you specify (e.g., `'activeUsers'`).
- `$count` is often used when you want to know the number of matching documents after applying filters.

---

## 3. **$group** Operator
The `$group` operator is used to group documents by a specified field. It allows you to perform aggregate operations such as sum, average, count, etc., on grouped data.

### Example:
```javascript
db.users.aggregate([
    {
        '$group': {
            '_id': '$favoriteFruit',
            'userCount': { '$sum': 1 }
        }
    }
])
```
This query groups the users by their favorite fruit and counts how many users prefer each fruit.

### Key Notes:
- The `_id` field is mandatory in `$group` and defines how documents are grouped (can be a field, expression, or constant).
- Common aggregate operators used with `$group`:
    - `$sum`: Adds the values in the field.
    - `$avg`: Computes the average of the values.
    - `$min`, `$max`: Finds the minimum/maximum values.
    - `$push`: Creates an array of values.
    - `$first`, `$last`: Returns the first or last value in the group.

---

## 4. **$avg** Operator
The `$avg` operator calculates the average value of a field over the documents in the group.

### Example:
```javascript
db.users.aggregate([
    {
        '$group': {
            '_id': null,
            'averageAge': { '$avg': '$age' }
        }
    }
])
```
This query calculates the average age of all users.

### Key Notes:
- `$avg` is often used to calculate averages such as age, salary, or other numerical values.
- It can also be used to average values after grouping documents.

---

## 5. **$sort** Operator
The `$sort` operator is used to order documents in ascending or descending order based on specified fields.

### Example:
```javascript
db.users.aggregate([
    {
        '$group': {
            '_id': '$favoriteFruit',
            'userCount': { '$sum': 1 }
        }
    },
    { '$sort': { 'userCount': -1 } },
    { '$limit': 1 }
])
```
This query sorts the fruits by the number of users who like them, in descending order.

### Key Notes:
- `$sort` supports both ascending (`1`) and descending (`-1`) order.
- Sorting is done after grouping or transformations, but it can be computationally expensive on large datasets.

---

## 6. **$limit** Operator
The `$limit` operator is used to restrict the number of documents passing through the pipeline.

### Example:
```javascript
db.users.aggregate([
    { '$sort': { 'userCount': -1 } },
    { '$limit': 1 }
])
```
This query limits the output to only the most common favorite fruit.

### Key Notes:
- `$limit` is typically used to reduce the size of the output after sorting or grouping operations.
- It is very useful for selecting the top N items (e.g., top 5 users, top 1 product).

---

## 7. **$unwind** Operator
The `$unwind` operator is used to flatten an array field into separate documents, creating one document for each element in the array.

### Example:
```javascript
db.users.aggregate([
    { '$unwind': '$tags' },
    { '$group': { '_id': '$name', 'tagCount': { '$sum': 1 } } }
])
```
This query unwinds the `tags` array so that each tag is treated as a separate document. Then, it counts how many tags each user has.

### Key Notes:
- `$unwind` is useful when you need to work with array data and treat each element as a separate document.
- If the array is empty, it will be excluded unless you use the `preserveNullAndEmptyArrays: true` option.

---

## 8. **$project** Operator
The `$project` operator reshapes each document in the stream by specifying which fields to include or exclude.

### Example:
```javascript
db.users.aggregate([
    { '$match': { 'tags': 'consequat', 'isActive': false } },
    { '$project': { 'name': 1, 'age': 1 } }
])
```
This query selects only the `name` and `age` fields of users who have 'consequat' as one of their tags and are inactive.

### Key Notes:
- `$project` allows for including/excluding specific fields using `1` for inclusion and `0` for exclusion.
- You can also use `$project` to add computed fields or modify the structure of the document.

---

## 9. **$in** Operator
The `$in` operator is used to check if a value is contained within an array.

### Example:
```javascript
db.users.aggregate([
    { '$match': { 'tags': { '$in': ['enim'] } } }
])
```
This query finds users who have 'enim' as one of their tags.

### Key Notes:
- `$in` can be used to filter documents by checking if the field value matches any value in an array.
- It works with all types of values (strings, numbers, etc.) and is helpful for multi-value matching.

---

## 10. **$group** with Complex Expressions
You can also use expressions within `$group` to create more complex aggregations.

### Example:
```javascript
db.users.aggregate([
    {
        '$group': {
            '_id': '$gender',
            'averageAge': { '$avg': '$age' },
            'userCount': { '$sum': 1 }
        }
    }
])
```
This query groups users by gender, calculates the average age per gender, and counts the number of users in each group.

---

## Final Notes:
- **Aggregation Pipelines** are powerful tools for performing complex transformations and analyses on MongoDB data.
- Common operators like `$match`, `$group`, `$sort`, and `$limit` are often combined to filter, group, sort, and limit the results.
- The sequence of operations in a pipeline can greatly impact performance, so it is important to structure pipelines efficiently, especially with large datasets.

### Best Practices:
- Use `$match` early in the pipeline to filter data as early as possible.
- Be cautious when using `$unwind` and `$sort` on large datasets, as they are expensive operations.
- Combine `$project` and `$group` to reshape and aggregate your data according to your needs.


