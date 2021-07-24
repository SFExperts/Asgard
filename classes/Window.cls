@RestResource(urlMapping='/Account/*')
global class Window {
	@HttpGet
    global static Account getRecord() {
			return [Select Id, Name from Account Limit 1];
    }
}