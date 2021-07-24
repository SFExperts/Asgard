public class MetadataExample {
    
    public  Metadata.CustomMetadata customMetadata{get;set;}
    public void updateMetadata(){
        
        customMetadata  = new Metadata.CustomMetadata();
        customMetadata.fullName  = 
            'MyNamespace__MyMetadataTypeName.MyMetadataRecordName';
        
        Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
        customField.field = 'customField__c ';
        customField.value = 'New Value';
        
        customMetaData.values.add(customField);
        
        Metadata.DeployContainer deployContainer = new Metadata.DeployContainer();
        deployContainer.addMetadata(customMetaData);
		Id asyncResultId  = Metadata.Operations.enqueueDeployment(deployContainer, null);
        
        
        
    }

}