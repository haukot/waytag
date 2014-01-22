/** @jsx React.DOM */

var EventKindButton = React.createClass({
  handleClick: function(e) {
    this.props.onActivate({ name: this.props.name, key: this.props.key });
  },

  render: function() {
    var cx = React.addons.classSet;
    var classes = cx({
      'btn': true,
      'btn-lg': true,
      'btn-block': true,
      'active': this.props.isActive
    });

    return <a onClick={this.handleClick} className={classes} key={this.props.key}>{this.props.name}</a>
  }
})

var EventKindButtons = React.createClass({
  handleActivate: function(activeKind) {
    var kinds = this.props.kinds.map(function (kind) {
      kind.isActive = false;

      if (kind.key == activeKind.key) {
        kind.isActive = !kind.isActive;
      }

      return kind;
    });

    this.props.onKindChange(activeKind);
    this.setState({kinds: kinds});
  },

  getInitialState: function() {
    return { kinds: [] };
  },

  render: function() {
    var scope = this
    var eventKindButtons = this.props.kinds.map(function (kind) {
      return <EventKindButton key={kind.key} name={kind.name} isActive={kind.isActive} onActivate={scope.handleActivate} />;
    });

    return (
      <div className="event-selector type">
        {eventKindButtons}
      </div>
    );
  }
});

var SelectedStreet = React.createClass({
  handleClose: function(e) {
    this.props.onClose(this.props.name);
  },

  render: function() {
    return <span className="label label-success" key={this.props.name}>{this.props.name}<a onClick={this.handleClose} className="btn btn-danger">X</a></span>;
  }
});

var StreetSelect = React.createClass({
  getInitialState: function() {
    return { streets: this.props.streets };
  },

  handleDeleteSrtreet: function(name) {
    console.log(name)

    index = this.state.streets.indexOf(name);
    console.log(index)

    if (index != -1) {
      this.state.streets.splice(index, 1);
      this.setState({ streets: this.state.streets });
      this.props.onStreetsChange(this.state.streets);
    }
  },

  handleKeyPress: function(e) {
    if (e.charCode == 13) {
      var street = this.refs.select.getDOMNode().value;
      var streets = this.state.streets;

      if (streets.indexOf(street) == -1) {
        streets.push(street);
        this.props.onStreetsChange(streets);
        this.setState({ streets: streets });
        this.refs.select.getDOMNode().value = '';
      }

      e.preventDefault();
    }
  },

  render: function() {
    var scope = this;
    var selectedStreets = this.state.streets.map(function (street) {
      return <SelectedStreet key={street} name={street} onClose={scope.handleDeleteSrtreet} />;
    });

    return (
      <div className="control-group">
        <input ref="select" placeholder="Где?" onKeyPress={this.handleKeyPress} />
        <div className="clearfix"></div>
        {selectedStreets}
      </div>
    );
  }
});

var Preview = React.createClass({
  addZero: function(i) { if (i < 10) { return "0" + i } else { return "" + i } },

  formatedTime: function(time) {
    hours = time.getHours();
    minutes = time.getMinutes();
    return ['[', this.addZero(hours), ':', this.addZero(minutes), ']'].join('');
  },

  streets: function() {
    return this.props.streets.join(' x ');
  },

  formatedText: function() {
    return [this.formatedTime(this.props.time), this.props.kind.name, this.streets(), this.props.text, ' #' + gon.current_city.hashtag].join(' ')
  },

  progressText: function() {
    return this.formatedText().length + " / 140";
  },

  progressStyle: function() {
    var text = this.formatedText();
    return { width: Math.round(text.length / 140 * 100) + '%' };
  },

  isDanger: function() {
    var length = this.formatedText().length;
    if (length > 140 || length < 30) {
      return true;
    } else {
      return false;
    }
  },

  render: function() {
    var cx = React.addons.classSet;
    var classes = cx({
      'progress-bar': true,
      'progress-bar-danger': this.isDanger(),
      'progress-bar-success': !this.isDanger()
    });

    return (
      <div>
        <div className="preview well" ref="text">{this.formatedText()}</div>
        <div className="progress">
          <div className={classes} role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style={this.progressStyle()} >
            <span className="sr-only">{this.progressText()}</span>
          </div>
        </div>
      </div>
    );
  }
});

var PostForm = React.createClass({
  getInitialState: function() {
    return { time: new Date(), text: '', streets: [], kind: { name: "", key: "" } };
  },

  handleStreetsChange: function(streets) {
    this.setState({ streets: streets, time: new Date() });
  },

  handleKindChange: function(kind) {
    this.setState({ kind: kind, time: new Date() });
  },

  handleTextChange: function(e) {
    this.setState({ text: e.target.value, time: new Date() });
  },

  render: function() {
    return (
      <div>
        <div className="row">
          <div className="col-md-3">
            <EventKindButtons kinds={gon.kinds} onKindChange={this.handleKindChange} />
          </div>
          <div className="col-md-9">
            <div className="row">
              <div className="col-md-6">
                <StreetSelect onStreetsChange={this.handleStreetsChange} streets={this.state.streets} />
              </div>
              <div className="col-md-6">
                <textarea className="how" placeholder="Как?" rows="3" onChange={this.handleTextChange} value={this.state.text}></textarea>
              </div>
            </div>
            <br />
            <Preview time={this.state.time} streets={this.state.streets} text={this.state.text} kind={this.state.kind} />
          </div>
        </div>
        <br />
        <input className="send_form_text" name="api_report[text]" type="hidden" value={this.state.text}/>
        <input className="send_form_time" name="api_report[time]" type="hidden" value={this.state.time} />
        <input className="send_form_kind" name="api_report[event_kind]" type="hidden" value={this.state.kind.key} />
        <input className="send btn btn-primary btn-lg" name="commit" type="submit" value="Сообщить в @Ulway" />
      </div>
    );
  }
});
