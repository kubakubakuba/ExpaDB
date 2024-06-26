from util import RandomGen, SQLFormatter, write_file
import random, os

if __name__ == '__main__':
	#insert random tools
	rg = RandomGen('cs_CZ')
	sqlf = SQLFormatter()

	NUM_USERS = 50
	NUM_EVENTS = 150
	NUM_GROUPS = 5
	MAX_WORKSHOP_POINTS = 5
	NUM_TOOLS = 50000
	NO_PRICE_PERCENTAGE = 0.25
	USES_GROUP_TOOLS_MAX_PERCENTAGE = 0.1
	PROABILITY_PROVIDED = 0.2

	assert NUM_USERS >= 10

	full_users = rg.generate_full_users(NUM_USERS)

	#users do not need to provide their personal information, so some of them will have None in some fields
	#none cannot be in id_uzivatel, login, heslo, salt
	for i in range(len(full_users)):
		for j in range(4, len(full_users[i])):
			if random.random() < PROABILITY_PROVIDED:
				full_users[i] = full_users[i][:j] + (None,) + full_users[i][j+1:]

	users_sql = sqlf.insert('Uzivatel', ['id_uzivatel', 'login', 'heslo', 'salt', 'jmeno', 'email', 'telefon', 'psc', 'mesto', 'ulice', 'cislo'], full_users)

	print(f"Generated {NUM_USERS} users")
	write_file('gen/users.sql', users_sql)

	all_ids = [i + 1 for i in range(NUM_USERS)]
	
	#randomly select some number of vedouci from users
	vedouci = random.sample(full_users, random.randint(3, NUM_USERS//2 - 3))
	vedouci_ids = [u[0] for u in vedouci]
	vedouci_ids = [int(i) for i in vedouci_ids]
	
	#select one random user as vedouci
	hlavni_vedouci = random.choice(vedouci)
	hlavni_vedouci_id = int(hlavni_vedouci[0])

	#all ids that are not vedouci are ucastnici
	ucastnici_ids = [i for i in all_ids if i not in vedouci_ids]
	ucastnici_ids = [int(i) for i in ucastnici_ids]

	#insert ids of vedouci into Vedouci
 
	groups = ["Digitální astrofotografie", "CCD", "Deep sky", "Začátečníci", "Analogová astrofotografie", "Mezihvězdná hmota", "Měsíc", "Technická skupina", "Radioastronomie"]
	groups = [(i + 1, g) for i, g in enumerate(groups)]
	group_ids = [i + 1 for i in range(NUM_GROUPS)]

	groups_sql = sqlf.insert('Skupina', ['id_skupina', 'jmeno'], groups)
	print(f"Generated {NUM_GROUPS} groups")
	write_file('gen/groups.sql', groups_sql)

	#select one random group for each vedouci
	vedouci_data = [(v, random.choice(group_ids)) for v in vedouci_ids]
	#if vedouci is hlavni vedouci, they have no group (None)
	vedouci_data = [(v, g) if v != hlavni_vedouci_id else (v, None) for v, g in vedouci_data]

	vedouci_sql = sqlf.insert('Vedouci', ['id_uzivatel', 'vede'], vedouci_data)
	print(f"Generated {len(vedouci_ids)} vedouci")
	write_file('gen/vedouci.sql', vedouci_sql)

	#insert ids of ucastnici into Ucastnik
	#each ucastnik is a part of one group
	
	ucastnici_data = [(u, random.choice(group_ids)) for u in ucastnici_ids]
	
	ucastnici_sql = sqlf.insert('Ucastnik', ['id_uzivatel', 'soucasti_skupiny'], ucastnici_data)
	print(f"Generated {len(ucastnici_ids)} ucastnici")
	write_file('gen/ucastnici.sql', ucastnici_sql)

	actions = rg.generate_random_actions(NUM_EVENTS, vedouci_ids)
	actions_sql = sqlf.insert('Akce', ['id_akce', 'nazev', 'cas', 'popis', 'created_by'], actions)
	print(f"Generated {NUM_EVENTS} actions")
	write_file('gen/actions.sql', actions_sql)

	#some of actions are workshops some are lectures
	action_ids = [i + 1 for i in range(NUM_EVENTS)]
	workshops = random.sample(action_ids, random.randint(1, NUM_EVENTS - 1))
	lectures = [i for i in action_ids if i not in workshops]
	lectures = random.sample(lectures, random.randint(1, len(lectures)))

	places = rg.generate_random_places(len(workshops) + len(lectures))
	workshop_places = places[:len(workshops)]
	lecture_places = places[len(workshops):]

	workshop_ids = workshops
	lecture_ids = lectures

	workshops = [(i, p) for i, p in zip(workshops, workshop_places)]
	lectures = [(i, p) for i, p in zip(lectures, lecture_places)]

	workshop_sql = sqlf.insert('Workshop', ['id_akce', 'misto'], workshops)
	lecture_sql = sqlf.insert('Prednaska', ['id_akce', 'misto'], lectures)

	print(f"Generated {len(workshops)} workshops")
	write_file('gen/workshops.sql', workshop_sql)

	print(f"Generated {len(lectures)} lectures")
	write_file('gen/lectures.sql', lecture_sql)

	lecturers = rg.generate_names(random.randint(len(lectures), len(lectures)*2))
	#first add one lecturer to each lecture in tuples (id_prednaska, lecturer name)
	lecturers_lecture_ids = list(zip(lecture_ids, lecturers[:len(lecture_ids)]))
	#now add the rest of the lecturers to random lectures
	lecturers_lecture_ids += list(zip(random.sample(lecture_ids, len(lecturers) - len(lecture_ids)), lecturers[len(lecture_ids):]))

	lecturers_sql = sqlf.insert('Prednasejici', ['id_akce', 'jmeno'], lecturers_lecture_ids)
	print(f"Generated {len(lecturers_lecture_ids)} lecturers")
	write_file('gen/lecturers.sql', lecturers_sql)

	#workshops can have 0..N program points, with timestamp, name and workshop id
	#for each workshop, generate 0..MAX_WORKSHOP_POINTS program points
	program_points = []
	counter = 0
	for w_id in workshop_ids:
		points = rg.generate_random_words(random.randint(0, MAX_WORKSHOP_POINTS))
		times = rg.generate_random_times(len(points))
		for p in points:
			counter += 1
			program_points.append((counter, w_id, p, times.pop()))

	program_points_sql = sqlf.insert('Program', ['id_program', 'id_akce', 'nazev', 'cas_polozky'], program_points)
	print(f"Generated {len(program_points)} program points")
	write_file('gen/program_points.sql', program_points_sql)
 
	tools = rg.generate_random_tools(NUM_TOOLS)
	barcodes = rg.generate_random_barcodes(NUM_TOOLS)
	owners = rg.generate_names(NUM_TOOLS)
	prices = rg.generate_random_prices(NUM_TOOLS)
	#set random prices to None
	for i in range(len(prices)):
		if random.random() < NO_PRICE_PERCENTAGE:
			prices[i] = None

	tools = [(i + 1, b, t, o, p) for i, (b, t, o, p) in enumerate(zip(barcodes, tools, owners, prices))]
	tool_ids = [i + 1 for i in range(NUM_TOOLS)]

	#now loop through the tools and check if the barcode is unique and combination of (name, owner) is unique, if not, throw it out
 
	unique_tools = []
	unique_tool_ids = []
	unique_barcodes = []
	unique_tool_names = []
	for tool in tools:
		if tool[1] not in unique_barcodes and (tool[2], tool[3]) not in unique_tool_names:
			unique_tools.append(tool)
			unique_tool_ids.append(tool[0])
			unique_barcodes.append(tool[1])
			unique_tool_names.append((tool[2], tool[3]))
		else:
			print(f"Duplicate tool: {tool} name: {tool[2]} owner: {tool[3]} barcode: {tool[1]} - throwing it out")
			continue

	tools = unique_tools
	tool_ids = unique_tool_ids
	

	tools_sql = sqlf.insert('Vybaveni', ['id_vybaveni', 'inventarni_cislo', 'nazev', 'majitel', 'cena'], tools)
	print(f"Generated {NUM_TOOLS} tools")
	write_file('gen/tools.sql', tools_sql)

	#distribute the available tools among the groups (one tool can be used at most by one group)
	# a group can have 0..N tools assigned
	
	tools_per_group = random.sample(tool_ids, random.randint(0, USES_GROUP_TOOLS_MAX_PERCENTAGE*NUM_TOOLS))
	tools_per_group = [(i, random.choice(group_ids)) for i in tools_per_group]
	tools_per_group_sql = sqlf.insert('MaPrirazeno', ['id_vybaveni', 'id_skupina'], tools_per_group)

	print(f"Generated {len(tools_per_group)} tools per group")
	write_file('gen/tools_per_group.sql', tools_per_group_sql)
 
	#each tool can be used by 0..N users
	#each user can use 0..N tools
 
	users_tools = random.sample(tool_ids, random.randint(0, USES_GROUP_TOOLS_MAX_PERCENTAGE*NUM_TOOLS))
	users_tools = [(random.choice(ucastnici_ids), i) for i in users_tools]
	users_tools_sql = sqlf.insert('Pouziva', ['id_uzivatel', 'id_vybaveni'], users_tools)
	print(f"Generated {len(users_tools)} users tools")
	write_file('gen/users_tools.sql', users_tools_sql)

	#each user can sign up for 0..N workshops, while each workshop can have 0..N participants
	workshops_participants = []
	for w_id in workshop_ids:
		participants = random.sample(ucastnici_ids, random.randint(0, len(ucastnici_ids)//2))
		workshops_participants += [(p, w_id) for p in participants]

	workshops_participants_sql = sqlf.insert('SePrihlasujeNa', ['id_uzivatel', 'id_akce'], workshops_participants)
	print(f"Generated {len(workshops_participants)} workshops participants")
	write_file('gen/workshops_participants.sql', workshops_participants_sql)
	
	#workshops can be organized by 1..N vedouci, while each vedouci can organize 0..N workshops
	workshops_organizers = []
	for w_id in workshop_ids:
		organizers = random.sample(vedouci_ids, random.randint(1, min(5, len(vedouci_ids)//2)))
		workshops_organizers += [(o, w_id) for o in organizers]

	workshops_organizers_sql = sqlf.insert('Organizuje', ['id_uzivatel', 'id_akce'], workshops_organizers)
	print(f"Generated {len(workshops_organizers)} workshops organizers")
	write_file('gen/workshops_organizers.sql', workshops_organizers_sql)
	
	helper_organizers = []
	for w_id in workshop_ids:
		organizers = random.sample(ucastnici_ids, random.randint(1, min(2, len(ucastnici_ids)//2)))
		helper_organizers += [(o, w_id) for o in organizers]

	helper_organizers_sql = sqlf.insert('PomahaOrganizovat', ['id_uzivatel', 'id_akce'], helper_organizers)
	print(f"Generated {len(helper_organizers)} helper organizers")
	write_file('gen/helper_organizers.sql', helper_organizers_sql)

	is_mandatory = []
	for a_id in action_ids:
		groups = random.sample(group_ids, random.randint(1, len(group_ids)//2))
		is_mandatory += [(a_id, g) for g in groups]

	#not all groups have mandatory actions
	is_mandatory = random.sample(is_mandatory, random.randint(1, len(is_mandatory)))

	is_mandatory_sql = sqlf.insert('JePovinna', ['id_akce', 'id_skupina'], is_mandatory)
	print(f"Generated {len(is_mandatory)} mandatory actions")
	write_file('gen/is_mandatory.sql', is_mandatory_sql)

	#each vedouci can have 0..N subordinates
	rest_vedouci = [v for v in vedouci_ids if v != hlavni_vedouci_id]
	subordinates = random.sample(rest_vedouci, random.randint(1, len(rest_vedouci)))
	
	#superiors are the ones that are not subordinate
	superiors = [v for v in vedouci_ids if v not in subordinates]
	
	#each subordinate can have 0..N superiors
	#each superior has one hlavni vedouci
 
	superiors_data = []
	for s in subordinates:
		sup = random.sample(superiors, random.randint(0, len(superiors)//2))
		for superior in sup:
			superiors_data.append((superior, s))

	for superior in superiors:
		superiors_data.append((hlavni_vedouci_id, superior))

	subordinates_sql = sqlf.insert('JeVedoucim', ['nadrizeny', 'podrizeny'], superiors_data)
	print(f"Generated {len(superiors_data)} subordinates")
	write_file('gen/subordinates.sql', subordinates_sql)

	#each user can participate in 0..N events, while each event can have 0..N participants
	participants = []
	for a_id in action_ids:
		par = random.sample(ucastnici_ids, random.randint(0, len(ucastnici_ids)//2))
		participants += [(p, a_id) for p in par]

	participants_sql = sqlf.insert('SeUcastni', ['id_uzivatel', 'id_akce'], participants)
	print(f"Generated {len(participants)} participants")
	write_file('gen/participants.sql', participants_sql)