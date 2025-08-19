from http.server import BaseHTTPRequestHandler, HTTPServer
import datetime
from urllib.parse import urlparse
from urllib.parse import parse_qs
import json

class MyHandler(BaseHTTPRequestHandler):
    # Handle POST Requests
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        
        try:
            # Attempt to parse as JSON if applicable
            data = json.loads(post_data.decode('utf-8'))
            print(f"Received POST request with JSON data: {data}", flush=True)
        except json.JSONDecodeError:
            # Otherwise, print raw data
            print(f"Received POST request with raw data: {post_data.decode('utf-8')}", flush=True)

        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b"POST request received successfully!")
        
    # Handle GET Requests
    def do_GET(self):
        print(f"Recieved GET request from IP: {self.client_address[0]}")
        print(f"Time Recieved: {datetime.datetime.now()}")
        print("VALUES:")
        
        parsed_url = urlparse(self.path)
        captured_values = parse_qs(parsed_url.query)

        for key in captured_values:
            print(key, ":", captured_values[key])
        print()
        
def run_server():
    server_address = ('localhost', 1327)
    httpd = HTTPServer(server_address, MyHandler)
    print(f"Server running on http://{server_address[0]}:{server_address[1]}/")
    httpd.serve_forever()

if __name__ == '__main__':
    run_server()
