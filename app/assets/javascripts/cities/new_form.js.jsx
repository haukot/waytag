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
      <div className="event-selector">
        {eventKindButtons}
      </div>
    );
  }
});

var Preview = React.createClass({
  progressText: function() {
    return this.props.formatedTextLength + " / 140";
  },

  progressStyle: function() {
    return { width: Math.round(this.props.formatedTextLength / 140 * 100) + '%' };
  },

  render: function() {
    var cx = React.addons.classSet;
    var classes = cx({
      'progress-bar': true,
      'progress-bar-danger': this.props.isDanger,
      'progress-bar-success': !this.props.isDanger
    });

    return (
      <div>
        <div className="preview well" ref="text">{this.props.formatedText}</div>
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
  addZero: function(i) { if (i < 10) { return "0" + i } else { return "" + i } },

  formatedTime: function(time) {
    hours = time.getHours();
    minutes = time.getMinutes();
    return ['[', this.addZero(hours), ':', this.addZero(minutes), ']'].join('');
  },

  formatedText: function() {
    return [this.formatedTime(this.state.time), this.state.kind.name, this.state.text, ' #' + gon.current_city.hashtag].join(' ')
  },

  textWithKind: function() {
    return [this.state.kind.name, this.state.text].join(' ');
  },

  isDanger: function() {
    var length = this.formatedText().length;
    if (length > 140 || length < 30) {
      return true;
    } else {
      return false;
    }
  },

  getInitialState: function() {
    var kind = gon.kinds[0];
    kind.isActive = true;
    return { time: new Date(), text: '', kind: kind, sended: false };
  },

  handleKindChange: function(kind) {
    this.setState({ kind: kind, time: new Date() });
  },

  handleTextChange: function(e) {
    this.setState({ text: e.target.value, time: new Date() });
  },

  onSubmit: function(e) {
    this.setState({sended: true});
    if (this.state.sended) {
      return false;
    }
  },

  render: function() {
    var cx = React.addons.classSet;
    var buttonClasses = cx({
      'send': true,  'btn': true,  'btn-primary': true,  'btn-lg': true, 'enabled': !this.isDanger()
    });

    return (
      <div>
        <div className="row">
          <div className="col-xs-12 col-md-8 col-md-offset-2">
            <EventKindButtons kinds={gon.kinds} onKindChange={this.handleKindChange} />
            <textarea className="how" placeholder="Где?" rows="3" onChange={this.handleTextChange} value={this.state.text}></textarea>

            <Preview formatedTextLength={this.formatedText().length} formatedText={this.formatedText()} isDanger={this.isDanger()} />
            <input className={buttonClasses} name="commit" type="submit" value={"Сообщить в " + gon.current_city.twitter_name} disabled={this.isDanger()} onClick={this.onSubmit}/>
          </div>
        </div>

        <input className="send_form_text" name="report[text]" type="hidden" value={this.textWithKind()}/>
        <input className="send_form_time" name="report[time]" type="hidden" value={this.state.time} />
        <input className="send_form_kind" name="report[event_kind]" type="hidden" value={this.state.kind.key} />

      </div>
    );
  }
});
