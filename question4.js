function convertToCamelCase(obj) {
    const camelCaseObj = {};
    for (const key in obj) {
        const camelCaseKey = key.replace(/_([a-z])/g, (_, char) => char.toUpperCase());
        camelCaseObj[camelCaseKey] = obj[key];
    }
    return camelCaseObj;
}
const snakeCaseObj = {
    "first_name": "John",
    "last_name": "Doe",
    "email_address": "john.doe@example.com"
};

const camelCaseObj = convertToCamelCase(snakeCaseObj);
console.log(camelCaseObj);