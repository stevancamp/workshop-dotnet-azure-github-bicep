 targetScope = 'resourceGroup'

  module appService './appservice.bicep' = {
   name: 'appservice'
   params: {
     appName: 'workshop-dnazghbicep-stevancamp-${environment}'
     location: 'centralus'
   }
 }