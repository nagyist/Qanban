class BootStrap {

     def init = { servletContext ->

         switch (GrailsUtil.environment) {
            case "development":
            
                Phase p1 = new Phase(name:'Backlog')
                p1.addToCards(new Card(title:"Card #1",caseNumber:1,description:'blalbblalbabla'))

                Board b = new Board()
                            .addToPhases(p1)
                            .addToPhases(new Phase(name:'WIP'))
                            .addToPhases(new Phase(name:'Done'))
                            .save()


                break
        }

     }
     def destroy = {
     }
} 
