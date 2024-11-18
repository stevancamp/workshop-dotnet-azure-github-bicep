 param location string

 param appName string

 param environemnt string

 var appServicePropperties = {
       serverFarmId: appServicePlan.id
       httpsOnly: true
       siteConfig: {
         http20Enabled: true
         linuxFxVersion: 'DOTNETCORE|9.0'
         alwaysOn: true
         ftpsState: 'Disabled'
         minTlsVersion: '1.2'
         webSocketsEnabled: true
         healthCheckPath: '/api/healthz'
         requestTracingEnabled: true
         detailedErrorLoggingEnabled: true
         httpLoggingEnabled: true
       }
     }

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
      name: 'asp-${appName}'
      location: location
      sku: {
        name: 'S1'
      }
      kind: 'linux'
      properties: {
        reserved: true
      }
    }

resource appService 'Microsoft.Web/sites@2022-09-01' = {
    name: 'app-${appName}'
    location: location
    identity: {
     type: 'SystemAssigned'
    }
    properties: appServicePropperties
 }


     resource appSettings 'Microsoft.Web/sites/config@2022-09-01' = {
      name: 'appsettings'
      kind: 'string'
      parent: appService
      properties: {
          ASPNETCORE_ENVIRONMENT: environemnt
      }
    }

       resource appServiceSlot 'Microsoft.Web/sites/slots@2022-09-01' = {
      location: location
      parent: appService
      name: 'slot'
      identity: {
          type: 'SystemAssigned'
      }
      properties: appServicePropperties
   }

    resource appServiceSlotSetting 'Microsoft.Web/sites/slots/config@2022-09-01' = {
   name: 'appsettings'
   kind: 'string'
   parent: appServiceSlot
   properties: {
     ASPNETCORE_ENVIRONMENT: environemnt
   }
 }