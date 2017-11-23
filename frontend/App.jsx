import 'whatwg-fetch';
import React from 'react';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = { fullName: '', companyDomainName: '' };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleFullNameChange = this.handleFullNameChange.bind(this);
    this.handleCompanyDomainNameChange = this.handleCompanyDomainNameChange.bind(this);
  }

  handleFullNameChange(event) {
    this.setState({ fullName: event.target.value });
  }

  handleCompanyDomainNameChange(event) {
    this.setState({ companyDomainName: event.target.value });
  }

  handleSubmit() {
    const api = 'http://localhost:3000';
    fetch(api + `/email_address?company_domain=foo.com&full_name=One+Two`, {
      method: 'get',
      headers: {
        'Access-Control-Allow-Origin': true,
      },
      'Content-Type': 'application/json',
      credentials: 'include',
    }).then(function(response) {
      console.log("response", response.json())
    })
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit()}>
        <label>
          Full Name:
          <input type="text" value={this.state.fullName} onChange={this.handleFullNameChange} />
        </label>
        <label>
          Company Domain Name:
          <input type="text" value={this.state.companyDomainName} 
            onChange={this.handleCompanyDomainNameChange} /> 
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  };
};

export default App;
