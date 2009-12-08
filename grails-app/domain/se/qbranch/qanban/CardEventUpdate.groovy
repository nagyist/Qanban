package se.qbranch.qanban

class CardEventUpdate extends CardEvent {

    // TODO: Validera så att eventen inte sparas om inget värde har ändrats
    
    static constraints = {
        title( blank: false, length: 1..50)
        description( blank: true, nullable: true )
        caseNumber( blank: false)
    }


    static mapping = {
        columns {
            description type:'text'
        }
    }

    static transients = ['card']
    Card card

    String title
    String description
    String caseNumber

    public Card getCard(){
        if( !card && domainId ){
            card = Card.findByDomainId(domainId)
        }
        return card
    }

    public void setCard(card){
        this.card = card
        title = card.title
        description = card.description
        caseNumber = card.caseNumber
    }

    transient beforeInsert = {
        domainId = card.domainId
    }

    transient process(){

        card.title = title
        card.description = description
        card.caseNumber = caseNumber
        card.save()
    }
    
    String toString(){
        return "$dateCreated: $user updated the card info"
    }
}
