import requests
import time
time.sleep(60)

url = 'http://localhost:32410'
# myobj = {'a': '1', 'b': '2', 'c': '1'}

x = requests.get(url)

print(x.text)
