var Student = (function () {
    function Student(fname, mname, lname) {
        this.fname = fname;
        this.mname = mname;
        this.lname = lname;
        this.fullName = fname + " " + mname + " " + lname;
    }
    return Student;
}());
function greeter(person) {
    return "Hello, " + person.fname + " " + person.lname;
}
var user = new Student('Yasin', '--', 'Zamani');
document.body.innerHTML = greeter(user);
