const baseUrl = "https://erpbeta.cloudocz.com/api";
const authBaseUrl = "$baseUrl/auth/";
const taskBaseUrl = "$baseUrl/app/";

const loginurl = "${authBaseUrl}login";
const getTasksUrl = "${taskBaseUrl}tasks";
const addTasksUrl = "${taskBaseUrl}tasks/store";
const getTaskByIdUrl = "${taskBaseUrl}tasks/show/";
const updateTaskUrl = "${taskBaseUrl}tasks/update/";
const deleteTaskUrl = "${taskBaseUrl}tasks/destroy/";
