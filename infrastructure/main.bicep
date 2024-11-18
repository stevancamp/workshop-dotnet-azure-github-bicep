 @allowed(['dev', 'prod'])
 param environment string

 targetScope = 'resourceGroup'

 module appService './appservice.bicep' = {
   name: 'appservice'
   params: {
     appName: 'workshop-dnazghbicep-<YOURUSERNAMEHERE>-${environment}'
     location: 'centralus'
     environemnt: environemnt
   }
 }