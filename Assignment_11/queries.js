db.courses.mapReduce(
    function () {
        emit(this.course, this.students.length);
    },
    function (key, value) {
        return Array.sum(value);
    },

    {
        out: "students_per_course"
    }
);