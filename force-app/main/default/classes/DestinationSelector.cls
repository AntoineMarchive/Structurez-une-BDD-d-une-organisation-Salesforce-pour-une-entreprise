// // Classe de gestion des Destinations Salesforce. Interagit directement avec la base de données.
// public with sharing class DestinationSelector {

//     // Récupère toutes les destinations
//     public static List<Destination__c> getDestinations() {
//         return [
//             SELECT Id, Name, Cost_Per_Person_Per_Day__c 
//             FROM Destination__c
//         ];
//     }

//     // Crée une nouvelle destination
//     public static Destination__c createDestination(Destination__c newDestination) {
//         insert newDestination;
//         return newDestination;
//     }

//     // Met à jour une destination existante
//     public static Destination__c updateDestination(Destination__c destinationToUpdate) {
//         update destinationToUpdate;
//         return destinationToUpdate;
//     }

//     // Supprime une destination via son Id
//     public static void deleteDestination(Id destinationId) {
//         Destination__c destinationToDelete = [
//             SELECT Id 
//             FROM Destination__c 
//             WHERE Id = :destinationId 
//             LIMIT 1
//         ];
//         delete destinationToDelete;
//     }
// }
