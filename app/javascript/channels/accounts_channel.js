import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', () => {
  consumer.subscriptions.create("AccountsChannel", {
    connected() {
      console.log("Connected to the accounts channel");
    },

    disconnected() {
      console.log("Disconnected from the accounts channel");
    },

    received(data) {
      console.log("Received data: ", data);
      updateAccountsList(data);
    }
  });
});

function updateAccountsList(data) {
  const accountsContainer = document.getElementById('accounts');
  switch(data.action) {
    case 'create':
      accountsContainer.insertAdjacentHTML('beforeend', renderAccount(data.account));
      break;
    case 'update':
      const existingAccountDiv = document.getElementById(`account_${data.account.id}`);
      if (existingAccountDiv) {
        existingAccountDiv.outerHTML = renderAccount(data.account);
      }
      break;
    case 'destroy':
      const accountToRemove = document.getElementById(`account_${data.account.id}`);
      if (accountToRemove) {
        accountToRemove.remove();
      }
      break;
  }
}

function renderAccount(account) {
  const awardsHtml = account.awards.length > 0
      ? `<ul>${account.awards.map(award => `<li>${award.name}</li>`).join('')}</ul>`
      : '<span>No awards</span>';

  const fireDepartmentsHtml = account.fire_departments.length > 0
      ? `<ul>${account.fire_departments.map(fd => {
        const membership = fd.memberships.find(m => m.fire_department_id === fd.id);
        return `<li>${fd.name} ${membership ? `- ${membership.status} - from ${new Date(membership.start_date).toLocaleDateString()} - ${membership.role}` : ''}</li>`;
      }).join('')}</ul>`
      : '<span>No fire departments</span>';

  return `
    <div id="account_${account.id}" class="account">
      <p class="my-5"><strong class="block font-medium mb-1">Full Name:</strong> ${account.full_name}</p>
      <p class="my-5"><strong class="block font-medium mb-1">Member Code:</strong> ${account.member_code}</p>
      <p class="my-5"><strong class="block font-medium mb-1">Birth Date:</strong> ${new Date(account.birth_date).toLocaleDateString('en-US', { day: '2-digit', month: 'long', year: 'numeric' })}</p>
      <p class="my-5"><strong class="block font-medium mb-1">Email:</strong> <a href="mailto:${account.email}" class="underline">${account.email}</a></p>
      <p class="my-5"><strong class="block font-medium mb-1">Phone:</strong> ${account.phone}</p>
      <p class="my-5"><strong class="block font-medium mb-1">Permanent Address:</strong> ${account.permament_address}</p>
      <div class="my-5"><strong class="block font-medium mb-1">Awards:</strong> ${awardsHtml}</div>
      <div class="my-5"><strong class="block font-medium mb-1">Fire Departments:</strong> ${fireDepartmentsHtml}</div>
      <div class="actions">
        <a href="/accounts/${account.id}" class="rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium">Show this member</a>
        <a href="/accounts/${account.id}/edit" class="rounded-lg py-3 ml-2 px-5 bg-gray-100 inline-block font-medium">Edit this member</a>
      </div>
      <hr class="mt-6">
    </div>
  `;
}