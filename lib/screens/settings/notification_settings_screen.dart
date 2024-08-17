import 'package:flutter/material.dart';
import '../../colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http; 
class NotificationSettingsScreen extends StatefulWidget {
  final String selectedApartmentID;
  final String userID;

  const NotificationSettingsScreen({
    Key? key,
    required this.userID,
    required this.selectedApartmentID,
  }) : super(key: key);

@override
  _NotificationSettingsScreenState createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _forumNotifications = true;
  bool _surveyNotifications = true;
  bool _pollNotifications = true;
  bool _noticeNotifications = true;
  bool _visitorNotifications = true;
  bool _ivrCallNotifications = true;
  bool _staffNotifications = true;
  bool _patrolNotifications = true;
  bool _otherNotifications = true;
  bool _classifiedNotifications = true;
  bool _complaintNotifications = true;
  bool _bookingNotifications = true;
  bool _bookingCancelationNotifications = true;
  bool _newEventNotifications = true;
  bool _bookingReminderNotifications = true;
  bool _eventUpdatesNotifications = true;
  bool _smsNotifications = true;

  String? _selectedTone = 'Crystal';
  String? _selectedDuration = '20';
  String? _selectedFrequency = 'Daily';
  String? selectedTitle = '';

  final Map<String, String> _ringtones = {
    'Default': 'ringtones/default.mp3',
    'Carol': 'ringtones/carol.mp3',
    'Crystal': 'ringtones/crystal.mp3',
    'Doorbell': 'ringtones/doorbell.mp3',
  };
  final List<String> tileTitles = [
      "Community corner",
      "Gate",
      "Others",
      "Events",
      "Email and SMS"
  ];


  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _updateSelection(bool isExpanded,String selectedTitleName) {
      setState(() {
        selectedTitle = selectedTitleName;
      });
  }

  Future<void> _fetchNotificationSettings() async {
    // Mock API response
    // final response = await http.get(Uri.parse('https://api.example.com/notification-settings/${widget.userID}'));

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   setState(() {
    //     _visitorNotifications = data['visitorNotifications'];
    //     _ivrCallNotifications = data['ivrCallNotifications'];
    //     _staffNotifications = data['staffNotifications'];
    //     _patrolNotifications = data['patrolNotifications'];
    //     _selectedTone = data['selectedTone'];
    //     _selectedDuration = data['selectedDuration'];
    //   });
    // } else {
    //   // Handle error
    //   print('Failed to load notification settings');
    // }
  }


  @override
  void initState() {
    super.initState();
    // _fetchNotificationSettings();
  }


  void _togglePlayPause(String tone) async {
    if (_isPlaying && _currentlyPlayingTone == tone) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _audioPlayer.stop(); // Stop any previously playing tone
      await _audioPlayer.play(AssetSource(_ringtones[tone]!));
      setState(() {
        _isPlaying = true;
        _currentlyPlayingTone = tone;
      });
    }
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String? _currentlyPlayingTone;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.background),
        title: const Text('Notification settings', style: TextStyle(color: AppColors.background)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildExpandableTile(
              title: tileTitles[0],
              onExpansion:(bool isExpand)=>{_updateSelection(isExpand,tileTitles[0])},
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: AppColors.primary))
                  ),
                  child: Column(
                    children: [
                      _buildSwitchTile(
                          title: 'Forum notifications',
                          value: _forumNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _forumNotifications = value;
                            });
                          },
                        ),
                        _buildSwitchTile(
                          title: 'Survey notifications',
                          value: _surveyNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _surveyNotifications = value;
                            });
                          },
                        ),
                        _buildSwitchTile(
                          title: 'Poll notifications',
                          value: _pollNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _pollNotifications = value;
                            });
                          },
                        ),
                        _buildSwitchTile(
                          title: 'Notice notifications',
                          value: _noticeNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _noticeNotifications = value;
                            });
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
            _buildExpandableTile(
              title: tileTitles[1],
              onExpansion:(bool isExpand)=>{_updateSelection(isExpand,tileTitles[1])},
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: AppColors.primary))
                  ),
                  child: Column(
                    children: [
                       _buildSwitchTile(
                          title: 'Visitor notifications',
                          value: _visitorNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _visitorNotifications = value;
                            });
                          },
                        ),
                        _buildSwitchTile(
                          title: 'IVR call notifications',
                          value: _ivrCallNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _ivrCallNotifications = value;
                            });
                          },
                        ),
                        _buildSwitchTile(
                          title: 'Staff notifications',
                          value: _staffNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _staffNotifications = value;
                            });
                          },
                        ),
                        _buildSwitchTile(
                          title: 'Patrol notifications',
                          value: _patrolNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _patrolNotifications = value;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary)
                          ),
                          child: Column(
                            children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: const Text('Visitor notification tone', style: TextStyle(fontSize: 15.4, color: AppColors.textColor,),textAlign:TextAlign.justify,),
                                ),
                                ..._ringtones.keys.map((String tone) {
                                  return RadioListTile<String>(
                                    title: Text(tone),
                                    value: tone,
                                    groupValue: _selectedTone,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedTone = value;
                                      });
                                    },
                                    secondary: IconButton(
                                      icon: Icon(
                                        _isPlaying && _currentlyPlayingTone == tone ? Icons.pause : Icons.play_arrow,
                                        color: AppColors.primary,
                                      ),
                                      onPressed: () => _togglePlayPause(tone),
                                    ),
                                    activeColor: AppColors.primary,
                                  );
                                }).toList(),           
                            ]
                          )
                        ),
                        SizedBox(height: 16,),
                        Container(
                          child: DropdownButtonFormField<String>(
                            icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                            dropdownColor: AppColors.background,
                            value: _selectedDuration,
                            decoration: InputDecoration(
                              // labelStyle: const TextStyle(color: AppColors.inputLabelColor),
                              filled: true,
                              // fillColor: AppColors.inputFillColor,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Visitor notification duration',
                            ),
                            items: ['10','20','30','60'].map((String duration) {
                              return DropdownMenuItem<String>(
                                value: duration,
                                child: Container(
                                  child: Text(
                                    selectionColor: AppColors.textColor,
                                    duration+' Seconds',
                                    style: const TextStyle(color: AppColors.textColor),
                                  ),
                                ),
                                // child: Text(duration,style: TextStyle(color:AppColors.textColor),)
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDuration = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  )
                ],
            ),
            _buildExpandableTile(
              title: tileTitles[2],
              onExpansion:(bool isExpand)=>{_updateSelection(isExpand,tileTitles[2])},
              children: [
                _buildSwitchTile(
                  title: 'Classified notifications',
                  value: _classifiedNotifications,
                  onChanged: (bool value) {
                    setState(() {
                      _classifiedNotifications = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Complaint notifications',
                  value: _complaintNotifications,
                  onChanged: (bool value) {
                    setState(() {
                      _complaintNotifications = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Other notifications',
                  value: _otherNotifications,
                  onChanged: (bool value) {
                    setState(() {
                      _otherNotifications = value;
                    });
                  },
                ),
              ],
            ),
            _buildExpandableTile(
              title: tileTitles[3],
              onExpansion:(bool isExpand)=>{_updateSelection(isExpand,tileTitles[3])},
              children: [
                _buildSwitchTile(
                  title: 'Booking notifications',
                  value: _bookingNotifications,
                  onChanged: (bool value) {
                    setState(() {
                      _bookingNotifications = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Booking cancelation notifications',
                  value: _bookingCancelationNotifications,
                  onChanged: (bool value) {
                    setState(() {
                      _bookingCancelationNotifications = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'New event notifications',
                  value: _newEventNotifications,
                  onChanged: (bool value) {
                    setState(() {
                      _newEventNotifications = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Booking reminder notifications',
                  value: _bookingReminderNotifications,
                  onChanged: (bool value) {
                    setState(() {
                      _bookingReminderNotifications = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Event updates notifications',
                  value: _eventUpdatesNotifications,
                  onChanged: (bool value) {
                    setState(() {
                      _eventUpdatesNotifications = value;
                    });
                  },
                ),
              ],
            ),
            _buildExpandableTile(
              title: tileTitles[4],
              onExpansion:(bool isExpand)=>{_updateSelection(isExpand,tileTitles[4])},
              children: [
                _buildSwitchTile(
                  title: 'SMS notifications',
                  value: _smsNotifications,
                  onChanged: (bool value) {
                    setState(() {
                      _smsNotifications = value;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 26),
                  child: Container(
                          child: DropdownButtonFormField<String>(
                            icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                            dropdownColor: AppColors.background,
                            value: _selectedFrequency,
                            decoration: InputDecoration(
                              // labelStyle: const TextStyle(color: AppColors.inputLabelColor),
                              filled: true,
                              // fillColor: AppColors.inputFillColor,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Visitor notification duration',
                            ),
                            items: ['Never', 'Real Time', 'Daily', 'Weekly', 'Monthly'].map((String frequency) {
                              return DropdownMenuItem<String>(
                                value: frequency,
                                child: Container(
                                  child: Text(
                                    selectionColor: AppColors.textColor,
                                    frequency,
                                    style: const TextStyle(color: AppColors.textColor),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedFrequency = newValue;
                              });
                            },
                          ),
                      ) 
                  )               
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableTile({required String title, required List<Widget> children,required ValueChanged<bool> onExpansion}) {
    return GestureDetector(
      onTap: () => {
        print('Clicked...!!!')
      },
      child: ExpansionTile(
          collapsedIconColor: AppColors.textColor,
          title: Text(
            title,
            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
          ),
          iconColor: AppColors.primary,
          backgroundColor: AppColors.expandTileBackground,
          children: children,
          onExpansionChanged: (isExpanded)=>{onExpansion(isExpanded)},
          initiallyExpanded: selectedTitle == title,
      )
    );
    // return 
  }

  Widget _buildSwitchTile({required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return Transform.scale(
          scale: 0.9,
          child: SwitchListTile(
            title: Text(title, style: TextStyle(color: AppColors.textColor)),
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          )
      );
  }
}
