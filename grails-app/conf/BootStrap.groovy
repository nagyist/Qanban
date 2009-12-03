import se.qbranch.qanban.*
import org.apache.commons.codec.digest.DigestUtils as DU
import grails.util.GrailsUtil

class BootStrap {

    def authenticateService
    def authenticationManager
    def sessionController
    def eventService

    def init = { servletContext ->
        authenticationManager.sessionController = sessionController


        switch (GrailsUtil.environment) {

            case "test":

            Role role = new Role(description:"administrator access",authority:"ROLE_ADMIN")
            role.save()

            def md5pass = authenticateService.passwordEncoder("test")
            User user = new User(username: "testuser",
                                 userRealName:"Mr Test",
                                 passwd:md5pass,
                                 enabled:true,
                                 description:"testing, testing...",
                                 email:"test@test.com",
                                 authorities:role)

            if(user.save()) {
                role.addToPeople(user)
            }

            Phase p1 = new Phase(name:'Backlog', cardLimit: 10)
            p1.addToCards(new Card(title:"Card #1",caseNumber:1,description:'blalbblalbabla'))
            .addToCards(new Card(title:"Card #2",caseNumber:2,description:'blöblöblöblöbl'))

            Board b = new Board()
            .addToPhases(p1)
            .addToPhases(new Phase(name:'WIP', cardLimit: 5))
            .addToPhases(new Phase(name:'Done', cardLimit: 5))
            .save()

            break

            default:

            Role adminRole = new Role(description:"administrator access",authority:"ROLE_QANBANADMIN").save()
            Role userRole = new Role(description:"regular user access",authority:"ROLE_QANBANUSER").save()

            User regularUser = new User(username: "testuser",
                                     userRealName:"Test User",
                                     passwd:authenticateService.passwordEncoder("testuser"),
                                     enabled:true,
                                     description:"This is a regular user",
                                     email:"mattias.mirhagen@gmail.com",
                                     authorities:userRole)

            if(regularUser.save()) {
                userRole.addToPeople(regularUser)
            }

            User adminUser = new User(username: "testadmin",
                                     userRealName:"Admin User",
                                     passwd:authenticateService.passwordEncoder("testadmin"),
                                     enabled:true,
                                     description:"This is an admin user",
                                     email:"patrik.gardeman@gmail.com",
                                     authorities:adminRole)

            if(adminUser.save()) {
                userRole.addToPeople(adminUser)
                adminRole.addToPeople(adminUser)
            }

            Board board = new Board().save()

            eventService.persist(new PhaseEventCreate(name: "Backlog", position: 0, user: adminUser, board: board))
            eventService.persist(new PhaseEventCreate(name: "WIP", position: 1, cardLimit: 5, user: adminUser, board: board))
            eventService.persist(new PhaseEventCreate(name: "Done", position: 2, user: adminUser, board: board))

            eventService.persist(new CardEventCreate(title: "Card #1", caseNumber: 1, description: "The first card", phaseDomainId: (Phase.get(1).domainId), user: adminUser))
            eventService.persist(new CardEventCreate(title: "Card #2", caseNumber: 2, description: "The second card",phaseDomainId: (Phase.get(1).domainId), user: adminUser))
            
            break

        }

    }
    def destroy = {
    }
}
