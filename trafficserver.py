#Script to be used with trafficserver for caching.
#Requires bs4 and requests
import threading, queue, bs4, requests, time

def preloader(q):
    while True:
        flow = q.get()
        soup = bs4.BeautifulSoup(flow.response.content, "html.parser")
        if soup.find():
            for tag in soup.find_all(name="a"):
                link = tag["href"]
                res = requests.request("GET", link, headers=flow.response.headers)
                time.sleep(0.5)

class TrafficServer:
    def __init__(self):
        self.bodies = queue.Queue(maxsize=5000)
        self.preloader_thr = threading.Thread(target=preloader, args=(self.bodies,))
        self.preloader_thr.start()

    def request(self, flow):
        flow.request.scheme = "http"

    def response(self, flow):
        if not self.bodies.full():
            self.bodies.put(flow)
        else:
            pass

addons = [TrafficServer()]