var fetchURL = function(url, completion) {
	var settings = {
		'method': 'get',
		'headers': {
			'_values': {
				'Accept': 'text/html'
			}
		}
	}
	fetch(url, settings).then(function(response) {
		completion(response.content);
		console.log(response);
		return response.content;
	}).catch(function(e) {
		console.log(e);
	});
}
