describe('Address Book', function () {
    var addressBook,
        contact;

    beforeEach(function () {
        addressBook = new AddressBook();
        contact = new Contact();
    })
    it('should be enable add contact', function () {
        addressBook.addContact(contact);
        expect(addressBook.getContact(0)).toBe(contact);
    })

    it('should be able delete contact', function () {    
        addressBook.addContact(contact);
        addressBook.deleteContact(0);
        expect(addressBook.getContact(0)).not.toBeDefined();
    })
})

describe('Async Address Book', function () {
    var addressBook = new AddressBook();

    beforeEach(function (done) {
        addressBook.loadAsync(function () {
            done();
        })
    })

    it('should be load async', function (done) {
        expect(addressBook.isLoaded).toBe(true);
        done();
    })
})