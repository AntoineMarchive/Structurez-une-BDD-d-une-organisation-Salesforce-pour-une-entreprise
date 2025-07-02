// @isTest
// public class DestinationControllerTest {

//     @isTest
//     static void testCreateUpdateAndDeleteDestination() {
//         // Création d'une destination valide
//         Destination__c dest = new Destination__c(Name = 'Italie', Cost_Per_Person_Per_Day__c = 500);
//         Destination__c createdDest = DestinationController.createDestination(dest);
//         System.assertNotEquals(null, createdDest.Id, 'La destination doit être insérée');

//         // Mise à jour avec un coût modifié
//         createdDest.Cost_Per_Person_Per_Day__c = 550;
//         Destination__c updatedDest = DestinationController.updateDestination(createdDest);
//         System.assertEquals(550, updatedDest.Cost_Per_Person_Per_Day__c, 'Le coût doit être mis à jour');

//         // Suppression de la destination
//         DestinationController.deleteDestination(updatedDest.Id);
//         System.assertEquals(0, [SELECT COUNT() FROM Destination__c WHERE Id = :updatedDest.Id], 'La destination doit être supprimée');
//     }

//     @isTest
//     static void testCreateWithNegativeCost() {
//         Destination__c dest = new Destination__c(Name = 'Erreur', Cost_Per_Person_Per_Day__c = -100);
//         Test.startTest();
//         try {
//             DestinationController.createDestination(dest);
//             System.assert(false, 'Une exception aurait dû être levée pour un coût négatif');
//         } catch (Exception e) {
//             System.assert(e.getMessage().contains('cannot be negative'), 'Message d’erreur attendu');
//         }
//         Test.stopTest();
//     }

//     @isTest
//     static void testUpdateWithNegativeCost() {
//         Destination__c dest = new Destination__c(Name = 'Test Update', Cost_Per_Person_Per_Day__c = 300);
//         insert dest;
//         dest.Cost_Per_Person_Per_Day__c = -50;
//         Test.startTest();
//         try {
//             DestinationController.updateDestination(dest);
//             System.assert(false, 'Une exception aurait dû être levée lors de la mise à jour avec un coût négatif');
//         } catch (Exception e) {
//             System.assert(e.getMessage().contains('cannot be negative'), 'Message d’erreur attendu');
//         }
//         Test.stopTest();
//     }
// }
