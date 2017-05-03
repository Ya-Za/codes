/**
 * Manage contacts
 * @constructor
 */
function AddressBook() {
    this.isLoaded = false;
    this.contacts = [];
}

/**
 * Add contact
 * @ contact {Contact} contact Input contact
 */
AddressBook.prototype.addContact = function (contact) {
    this.contacts.push(contact);
}

/**
 * Get contact
 * @param {int} index 
 */
AddressBook.prototype.getContact = function (index) {
    return this.contacts[index];
}

/**
 * Delete contact
 * @param {int} index
 */
AddressBook.prototype.deleteContact = function (index) {
    this.contacts.splice(index, 1);
}

AddressBook.prototype.loadAsync = function (cb) {
    var self = this;
    setTimeout(function() {
        self.isLoaded = true;
        if (cb) {
            return cb();
        }
    }, 3);
}