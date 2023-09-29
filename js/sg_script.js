async function SecureGatewaySubmitForm(event) {
    event.preventDefault();  // Prevent the form from submitting the traditional way
    let SecureGatewayForm = document.getElementById('uploadForm');
    let SecureGatewayFormData = new FormData(SecureGatewayForm);

    try {
        let SecureGatewayResponse = await fetch(SecureGatewayForm.action, {
            method: 'POST',
            body: SecureGatewayFormData
        });
        
        if(SecureGatewayResponse.ok) {
            let SecureGatewayData = await SecureGatewayResponse.text();
            document.getElementById('responseOutput').textContent = SecureGatewayData;
        } else {
            document.getElementById('responseOutput').textContent = 'Error uploading file.';
        }
    } catch (SecureGatewayError) {
        document.getElementById('responseOutput').textContent = 'Error: ' + SecureGatewayError.message;
    }
}
