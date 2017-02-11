package by.bsuir.runets.runetwork.core.database.model;

import by.bsuir.runets.runetwork.core.database.model.enums.ContactType;

import javax.persistence.*;

@Entity
@Table(name = "Contact")
public class Contact {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer contactId;

    @Column(name = "type")
    @Enumerated(EnumType.STRING)
    private ContactType contactType;

    @Column(name = "contact")
    private String value;

    public Integer getContactId() {
        return contactId;
    }

    public void setContactId(Integer contactId) {
        this.contactId = contactId;
    }

    public ContactType getContactType() {
        return contactType;
    }

    public void setContactType(ContactType contactType) {
        this.contactType = contactType;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
