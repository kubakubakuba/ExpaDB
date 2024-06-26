from faker import Faker
import random, datetime
from hashlib import sha256

class RandomGen:
	def __init__(self, locale='en_US'):
		self.fake = Faker(locale)

	def generate_usernames(self, num):
		usernames = []
		for _ in range(num):
			usernames.append(self.fake.user_name())

		return usernames

	def generate_names(self, num):
		names = []
		for _ in range(num):
			names.append(self.fake.name())

		return names

	def generate_addresses(self, num):
		addr = []
		for _ in range(num):
			addr.append(self.fake.address())

		addr = [ (' '.join(a.split('\n')[0].split(' ')[:-1]), a.split('\n')[0].split(' ')[-1], str(a.split('\n')[1].split(' ')[0]) + str(a.split('\n')[1].split(' ')[1]), a.split('\n')[1].split(' ')[2],) for a in addr]

		return addr

	def generate_emails(self, num):
		emails = []
		for _ in range(num):
			emails.append(self.fake.email())

		return emails
	
	def generate_phones(self, num):
		nums = []
		for _ in range(num):
			nums.append(self.fake.phone_number())

		return nums

	def generate_passwords(self, num):
		passwords = []
		salts = []

		for i in range(num):
			salt = sha256(self.fake.word().encode('utf-8')).hexdigest()[:16]
			salts.append(salt)
			string = f"{self.fake.word()}_{random.randint(0, 1000)}{salt}"
			passwords.append(sha256(string.encode('utf-8')).hexdigest())

		return zip(passwords, salts)

	def generate_random_telescope(self):
		make = ['Celestron', 'Meade', 'Orion', 'Sky-Watcher', 'Takahashi']
		telescope_type = ['refractor', 'reflector', 'compound']
		focal_length = random.randint(300, 1500)
		diameter = random.randint(75, 300)
		aperture = round(focal_length / diameter, 2)
		
		telescope = f"{random.choice(make)} {random.choice(telescope_type)} {focal_length}/{diameter} f{aperture}"

		return telescope

	def generate_random_camera(self):
		make = ['Canon', 'Sony', 'Fujifilm', 'Touptek', 'ZWO ASI', 'Hasselblad', 'Nikon', 'Olympus', 'Panasonic', 'Pentax', 'Leica', 'Ricoh', 'Sigma', 'YI Technology', 'Kodak', 'Polaroid', 'GoPro', 'DJI', 'Blackmagic Design', 'RED Digital Cinema', 'Arri']
		models = {
			'Canon': ['EOS 5D', 'EOS 6D', 'EOS 7D', 'EOS 80D', 'EOS 200D', 'EOS 4000D', 'EOS 800D', 'EOS 1300D', 'EOS 750D', 'EOS 700D', 'EOS 2000D'],
			'Sony': ['A7 III', 'A7R III', 'A9', 'A6500', 'A6300', 'A6000', 'A5100', 'A5000'],
			'Fujifilm': ['X-T3', 'X-T2', 'X-H1', 'X-Pro2', 'X-T20', 'X-T100', 'X-A5', 'X-E3', 'X-A3'],
			'Touptek': ['ATR183C', 'ATR2600C', 'ATR342C', 'ATR460C', 'ATR620C', 'ATR8300C', 'ATR9800C'],
			'ZWO ASI': ['ASI120MM', 'ASI1600MM', 'ASI294MC', 'ASI071MC', 'ASI533MC', 'ASI183MC', 'ASI2600MC', 'ASI6200MM'],
			'Hasselblad': ['H6D-100c', 'H6D-50c', 'X1D-50c', 'X1D II 50c'],
			'Nikon': ['D850', 'D750', 'D500', 'D7500', 'D5600', 'D3500', 'D3400', 'D3300'],
			'Olympus': ['OM-D E-M1X', 'OM-D E-M1 Mark II', 'OM-D E-M5 Mark II', 'OM-D E-M10 Mark III', 'PEN-F'],
			'Panasonic': ['Lumix GH5', 'Lumix G9', 'Lumix GH5S', 'Lumix GH4', 'Lumix G80', 'Lumix G7', 'Lumix GX80', 'Lumix GX800', 'Lumix GX9'],
			'Pentax': ['K-1', 'K-70', 'KP', 'K-S2', 'K-3 II', 'K-50', 'K-500'],
			'Leica': ['M10', 'SL', 'Q', 'CL', 'TL2', 'S', 'X-U', 'D-Lux', 'V-Lux'],
			'Ricoh': ['GR III', 'GRII', 'WG-50', 'Theta V', 'Theta SC'],
			'Sigma': ['fp', 'sd Quattro H', 'sd Quattro', 'dp0 Quattro', 'dp1 Quattro', 'dp2 Quattro', 'dp3 Quattro'],
			'YI Technology': ['M1', '4K+', '4K', 'Lite', 'Discovery', 'Action Camera'],
			'Kodak': ['Pixpro AZ901', 'Pixpro AZ652', 'Pixpro AZ421', 'Pixpro AZ252', 'Pixpro AZ401', 'Pixpro AZ365', 'Pixpro AZ361', 'Pixpro AZ251'],
			'Polaroid': ['Snap', 'Pop', 'Cube', 'OneStep 2', 'OneStep+', 'Mint', 'i-Type', 'Z2300', 'Z340', 'Z2300'],
			'GoPro': ['Hero8 Black', 'Hero7 Black', 'Hero7 Silver', 'Hero7 White', 'Hero6 Black', 'Hero5 Black', 'Hero5 Session', 'Fusion', 'Max'],
			'DJI': ['Mavic 2 Pro', 'Mavic 2 Zoom', 'Mavic Air', 'Mavic Pro', 'Spark', 'Phantom 4 Pro', 'Phantom 4 Advanced', 'Inspire 2', 'Osmo Action', 'Osmo Pocket'],
			'Blackmagic Design': ['Pocket Cinema Camera 4K', 'Pocket Cinema Camera 6K', 'Micro Cinema Camera', 'Micro Studio Camera 4K', 'URSA Mini Pro 4.6K', 'URSA Mini 4K'],
			'RED Digital Cinema': ['Raven', 'Scarlet-W', 'Epic-W', 'Weapon 8K', 'Helium 8K', 'Monstro 8K', 'Dragon-X', 'Gemini 5K'],
			'Arri': ['Alexa LF', 'Alexa Mini LF', 'Alexa SXT', 'Alexa Mini', 'Amira', 'Alexa XT', 'Alexa Classic', 'Alexa Studio', 'Alexa Plus']
		}

		current = random.choice(make)
		camera = f"{current} {random.choice(models[current])}"

		#generate a lens
		if random.random() < 0.5:
			camera = f"{current} {random.randint(10, 300)}mm f/{random.randint(1, 2)}.{random.randint(0, 9)}"

		return camera
	
	def generate_random_basic_tool(self):
		choice = ["krytka", "šroubovák", "klíč", "kleště", "nůž", "pilník", "kombinéza"]
		return random.choice(choice)

	def generate_random_tool(self):
		r = random.random()
		if r < 0.49:
			return self.generate_random_telescope()
		elif r < 0.98:
			return self.generate_random_camera()

		return self.generate_random_basic_tool()

	def generate_random_tools(self, num):
		tools = []
		for _ in range(num):
			tools.append(self.generate_random_tool())

		return tools
	
	def generate_random_barcodes(self, num):
		barcodes = []
		for _ in range(num):
			barcodes.append(self.fake.localized_ean(length=13))
		
		return barcodes

	def generate_random_prices(self, num):
		prices = []
		for _ in range(num):
			prices.append(round(random.uniform(2000, 50000), 2))

		return prices

	def generate_full_users(self, num):
		'''Stores users in a list of tuples in the following format:
		(username, password, salt, name, email, phone, city, zip_code, street, number)
		'''
		names = self.generate_names(num)
		#usernames = self.generate_usernames(num)
		#usernames are the same as names without spaces in random uppercase, lowercase, no diacritics, with _random number at the end, there can also be a random character at the end
		usernames = [n.replace(' ', '').lower() + f"_{random.randint(0, 1000)}{random.choice('abcdefghijklmnopqrstuvwxyz@#_!.')}" for n in names]
		#remove diacritics from usernames
		usernames = [u.replace('á', 'a').replace('č', 'c').replace('ď', 'd').replace('é', 'e').replace('ě', 'e').replace('í', 'i').replace('ň', 'n').replace('ó', 'o').replace('ř', 'r').replace('š', 's').replace('ť', 't').replace('ú', 'u').replace('ů', 'u').replace('ý', 'y').replace('ž', 'z') for u in usernames]

		pwds = self.generate_passwords(num)
		tel = self.generate_phones(num)
		addresses = self.generate_addresses(num)
		emails = self.generate_emails(num)

		street, number, city, zip_code = zip(*addresses)

		users = [(i + 1, u, p[0], p[1], n, e, t, c, z, s, num) for i, (u, p, n, e, t, z, c, s, num) in enumerate(zip(usernames, pwds, names, emails, tel, zip_code, city, street, number))]

		#remove duplicate usernames
		users_data = []
		for user in users:
			if user[1] not in [u[1] for u in users_data]:
				users_data.append(user)

		return users
	
	def generate_random_words(self, num):
		groups = []
		for _ in range(num):
			groups.append(self.fake.word())

		return groups
	
	def generate_random_times(self, num):
		times = []
		#generate a random time this month as a sql timestamp
		for _ in range(num):
			times.append(self.fake.date_time_this_month().strftime('%Y-%m-%d %H:%M:%S'))

		return times

	def generate_random_places(self, num):
		places = []
		for _ in range(num):
			places.append(self.fake.city())

		return places
	
	def generate_random_text(self, num):
		texts = []
		for _ in range(num):
			texts.append(self.fake.text())

		return texts
	
	def generate_random_actions(self, num, ids_vedouci):
		names = self.generate_random_words(num)
		times = self.generate_random_times(num)
		texts = self.generate_random_text(num)

		actions = [(i + 1, n, t, txt, random.choice(ids_vedouci)) for i, (n, t, txt) in enumerate(zip(names, times, texts))]

		return actions

class SQLFormatter:
	def __init__(self):
		pass

	def insert(self, where, column_names, data):	
		sql = f"INSERT INTO {where}\n"
		sql += f"({', '.join(column_names)})\n"
		sql += "VALUES\n"

		for row in data:
			sql += "("
			for item in row:
				if item is None:
					sql += "NULL, "
				else:
					sql += f"'{item}', " if isinstance(item, str) else f"{item}, "
			sql = sql[:-2] + "),\n"

		return sql[:-2] + ';'
	
	def insert_single(self, where, column_names, data):
		sql = f"INSERT INTO {where}\n"
		sql += f"({', '.join(column_names)})\n"

		sql += "VALUES\n"

		for row in data:
			if isinstance(row, str):
				sql += f"('{row}'),\n"
			else:
				sql += f"({row}),\n"

		return sql[:-2] + ';'
	
def write_file(filename, data):
	with open(filename, 'w') as f:
		f.write(f"/*\nAutogenerated {filename} on {datetime.datetime.now()}\nJakub Pelc, DBS24\n*/\n\n")
		f.write(data)
		f.write(f"\n\n/* End of file {filename} */")