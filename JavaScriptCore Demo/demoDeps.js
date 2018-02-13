var self = this;

function addEventListener() {}
function removeEventListener() {}

function sanity() { console.log("You're sane."); }

var performance = {
    mark: function() {},
    measure: function() {},
    clearMarks: function() {},
    clearMeasures: function() {},
    now: function() { return +new Date()},
}

function Headers(values) {
    this._values = values || {};
}

Headers.prototype.append = function(name, value) {
    this._values[name] = value;
}

Headers.prototype.delete = function(name) {
    delete this._values[name];
}

Headers.prototype.entries = function() {
    const result = [];
    for (let key in this._values) {
        result.push([key, this._values[key]]);
    }
    return result;
}

Headers.prototype.get = function(name) {
    return this._values[name];
}

Headers.prototype.has = function(name) {
    return name in this._values;
}

Headers.prototype.keys = function() {
    const result = [];
    for (let key in this._values) {
        result.push(key);
    }
    return result;
}

Headers.prototype.set = function(name, value) {
    this._values[name] = value;
}

Headers.prototype.values = function(name, value) {
    const result = [];
    for (let key in this._values) {
        result.push(this._values[key]);
    }
    return result;
}

function Response(url, statusCode, content, headers) {
    this.headers = headers;
    this.ok = statusCode >= 200 && statusCode < 300;
    this.redirected = false;
    this.status = statusCode;
    // this.statusText = Response.statusToCode[statusCode];
    this.type = 'basic';
    this.url = url;
    this.useFinalURL = true;
    this.body = null;
    this.content = content;
    this.bodyUsed = true;
}

Response.prototype.arrayBuffer = function() {
    return Promise.reject(new Error("arrayBuffer Not implemented"));
}

Response.prototype.blob = function() {
    return Promise.reject(new Error("blob Not implemented"));
}

Response.prototype.formData = function() {
    return Promise.reject(new Error("formData Not implemented"));
}

Response.prototype.json = function() {
    return Promise.resolve(JSON.parse(this.content));
}

Response.prototype.text = function() {
    return Promise.resolve(this.content);
}

Response.prototype.clone = function() {
    return new Response(this.url, this.status, this.content, this.headers);
}

Response.prototype.error = function() {
    return Promise.reject(new Error("Response.error Not implemented"));
}

Response.prototype.redirect = function() {
    return Promise.reject(new Error("Response.redirect Not implemented"));
}

Response.statusToCode = {
    200: 'OK',
};
