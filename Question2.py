def process(d):
    status = d.get('status')
    actions = {
        'active': 'Active',
        'inactive': 'Inactive'
    }
    print(actions.get(status, 'Unknown'))
mkdir