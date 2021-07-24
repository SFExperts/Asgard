public class UpdateContactPageLayout {
    public void UpdateContactPageLayout(){
        
    }
    public MetaData.Layout addLayoutItem(){
    	List<MetaData.MetaData> layoutsList  = new List<Metadata.Metadata>();
		layoutsList  = MetaData.Operations.retrieve(Metadata.MetadataType.Layout, 
                                     new List<String>{'Contact-Contact Layout'});
        Metadata.Layout layoutMetadata = (Metadata.Layout) layoutsList.get(0);
        
        Metadata.LayoutSection contactLayoutSection  = null;
        List<Metadata.LayoutSection> layoutSections = layoutMetadata.layoutSections;
        for (Metadata.LayoutSection section : layoutSections) {
            System.Debug('Section Label: ' + section.label);
            if (section.label == 'Additional Information') {
                contactLayoutSection  = section;
                System.Debug('Section Located: ' + section.label);
                break;
            }
        }       
        List<Metadata.LayoutColumn > contactColumns = new List<Metadata.LayoutColumn >();
        contactcolumns = contactLayoutSection.layoutColumns; 
        
        List<Metadata.LayoutItem> contactLayoutItems = new List<Metadata.LayoutItem>();
        contactLayoutItems=contactcolumns[0].layoutItems;
        
        Metadata.LayoutItem newField = new Metadata.LayoutItem();
        newField.behavior = Metadata.UiBehavior.Edit;
        newField.field = 'AMAPI__Apex_MD_API_Twitter_name__c';
        contactLayoutItems.add(newField);
        return layoutMetaData;
    }
    
    // Create metadata container 
    public Metadata.DeployContainer constructDeploymentRequest() {
        Metadata.DeployContainer container = new Metadata.DeployContainer();
        // Add components to container         
        Metadata.Layout layoutMetadata = addLayoutItem();
        container.addMetadata(layoutMetadata);
        return container;
    }
    // Deploy metadata
    public void deploy(Metadata.DeployContainer container) {
        // Create callback. 
        //PostInstallCallback callback = new PostInstallCallback();
        // Deploy the container with the new components. 
        Id asyncResultId = Metadata.Operations.enqueueDeployment(container, new PostInstallCallback());
    }
    
}