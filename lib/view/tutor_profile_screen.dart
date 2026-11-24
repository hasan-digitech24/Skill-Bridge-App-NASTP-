import 'package:flutter/material.dart';

import '../../../controllers/tutor_profile_controller.dart';
import '../../../models/availability_model.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/date_helper.dart';
import '../../../widgets/tutor/availability_slot.dart';
import '../../../widgets/tutor/initials_avatar.dart';

class TutorProfileScreen extends StatefulWidget {
  /// Connect this to your app's real logout/auth flow.
  final VoidCallback? onLogout;

  const TutorProfileScreen({super.key, this.onLogout});

  @override
  State<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
  late final TutorProfileController controller;
  late final TextEditingController aboutField;
  late final TextEditingController rateField;

  @override
  void initState() {
    super.initState();
    controller = TutorProfileController();
    aboutField = TextEditingController(text: controller.draft.about);
    rateField = TextEditingController(text: controller.rateText);
  }

  @override
  void dispose() {
    aboutField.dispose();
    rateField.dispose();
    controller.dispose();
    super.dispose();
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _showEditInfoDialog() async {
    final nameField = TextEditingController(text: controller.draft.name);
    final designationField =
        TextEditingController(text: controller.draft.designation);

    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameField,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: designationField,
              textCapitalization: TextCapitalization.words,
              decoration:
                  const InputDecoration(labelText: 'Professional designation'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Done')),
        ],
      ),
    );

    if (saved == true) {
      controller.updateBasicInfo(nameField.text, designationField.text);
    }
  }

  Future<void> _showAddSubjectDialog() async {
    final subjectField = TextEditingController();

    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add subject'),
        content: TextField(
          controller: subjectField,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(hintText: 'e.g. Flutter'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, subjectField.text),
              child: const Text('Add')),
        ],
      ),
    );

    if (name == null || !mounted) return;
    if (!controller.addSubject(name)) {
      _showMessage('Enter a new subject name');
    }
  }

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You will need to sign in again.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Logout',
                  style: TextStyle(color: AppColors.red))),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    if (widget.onLogout != null) {
      widget.onLogout!();
    } else {
      _showMessage('Logout is not connected to authentication yet.');
    }
  }

  void _save() {
    controller.setAbout(aboutField.text);
    final error = controller.save();
    _showMessage(error ?? 'Changes saved');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final topPadding = MediaQuery.of(context).padding.top;
        return ColoredBox(
          color: AppColors.white,
          child: ListView(
            padding: EdgeInsets.fromLTRB(16, topPadding + 16, 16, 24),
            children: [
              _buildHeader(),
              const SizedBox(height: 18),
              _buildProfileRow(),
              _divider(),
              _buildAbout(),
              _divider(),
              _buildSubjects(),
              _divider(),
              _buildRateAndModes(),
              _divider(),
              _buildAvailability(),
              _divider(),
              _buildButtons(),
            ],
          ),
        );
      },
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Divider(height: 1, color: AppColors.divider),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TUTOR ACCOUNT',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: AppColors.primary)),
              SizedBox(height: 4),
              Text('My Profile',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: AppColors.navy)),
            ],
          ),
        ),
        GestureDetector(
          onTap: _showEditInfoDialog,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.edit_outlined,
                color: AppColors.primary, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileRow() {
    final tutor = controller.draft;
    return Row(
      children: [
        SizedBox(
          width: 58,
          height: 58,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              InitialsAvatar(name: tutor.name, size: 56, radius: 14),
              Positioned(
                right: -4,
                bottom: -4,
                child: GestureDetector(
                  onTap: _showEditInfoDialog,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: const Icon(Icons.edit,
                        size: 11, color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tutor.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navy)),
              if (tutor.designation.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(tutor.designation,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textGrey)),
              ],
              if (tutor.isVerified) ...[
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.check, size: 12, color: AppColors.primary),
                    SizedBox(width: 4),
                    Text('Verified tutor',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary)),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title, String actionText, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.navy)),
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(actionText,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary)),
          ),
        ),
      ],
    );
  }

  Widget _buildAbout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('About you', controller.isEditingAbout ? 'Done' : 'Edit',
            controller.toggleAboutEditing),
        const SizedBox(height: 8),
        if (controller.isEditingAbout)
          TextField(
            controller: aboutField,
            onChanged: controller.setAbout,
            maxLines: 4,
            style: const TextStyle(fontSize: 11, color: AppColors.navy),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background,
              hintText: 'Tell students about yourself',
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          )
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              controller.draft.about.isEmpty
                  ? 'Tell students about yourself'
                  : controller.draft.about,
              style: TextStyle(
                  fontSize: 11,
                  height: 1.4,
                  color: controller.draft.about.isEmpty
                      ? AppColors.textMuted
                      : AppColors.textGrey),
            ),
          ),
      ],
    );
  }

  Widget _buildSubjects() {
    final subjects = controller.draft.subjects;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Subjects', '+ Add', _showAddSubjectDialog),
        const SizedBox(height: 8),
        if (subjects.isEmpty)
          const Text('No subjects added yet',
              style: TextStyle(fontSize: 11, color: AppColors.textMuted))
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final subject in subjects)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(subject.name,
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary)),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => controller.removeSubject(subject.name),
                        child: const Icon(Icons.close,
                            size: 12, color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildRateAndModes() {
    final tutor = controller.draft;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hourly rate',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy)),
              const SizedBox(height: 8),
              Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Text(tutor.currencySymbol,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textGrey)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: TextField(
                        controller: rateField,
                        onChanged: controller.setRate,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.navy),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintText: '0',
                        ),
                      ),
                    ),
                    const Text('/ hour',
                        style: TextStyle(
                            fontSize: 10, color: AppColors.textMuted)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Teaching modes',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy)),
              const SizedBox(height: 8),
              _modeRow('Online', tutor.teachesOnline, controller.setOnline),
              const SizedBox(height: 6),
              _modeRow(
                  'Home visit', tutor.teachesAtHome, controller.setHomeVisit),
            ],
          ),
        ),
      ],
    );
  }

  Widget _modeRow(String label, bool value, ValueChanged<bool> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: value,
              onChanged: (v) => onChanged(v ?? false),
              activeColor: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(label,
                style: const TextStyle(fontSize: 11, color: AppColors.navy)),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailability() {
    final isOn = controller.availability.isOn;
    final hours = AvailabilityModel.hours;
    final firstRow = hours.sublist(0, 4);
    final secondRow = hours.sublist(4);
    final date = controller.selectedWeekdayDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Weekly availability',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.navy)),
            GestureDetector(
              onTap: controller.toggleAvailability,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isOn ? AppColors.green : AppColors.textMuted,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(isOn ? 'ON' : 'OFF',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color:
                                isOn ? AppColors.green : AppColors.textMuted)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        const Text('Tap slots to turn ON or OFF',
            style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
        const SizedBox(height: 12),
        Opacity(
          opacity: isOn ? 1 : 0.45,
          child: IgnorePointer(
            ignoring: !isOn,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: controller.nextDay,
                  child: Container(
                    width: 58,
                    height: 86,
                    decoration: BoxDecoration(
                      color: AppColors.navy,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateHelper.weekdayShort(date).toUpperCase(),
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xB3FFFFFF)),
                        ),
                        const SizedBox(height: 2),
                        Text('${date.day}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white)),
                        const SizedBox(height: 2),
                        const Icon(Icons.unfold_more_rounded,
                            size: 12, color: Color(0x80FFFFFF)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      _slotRow(firstRow),
                      const SizedBox(height: 6),
                      _slotRow(secondRow),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _slotRow(List<int> hours) {
    return Row(
      children: [
        for (int i = 0; i < hours.length; i++) ...[
          if (i > 0) const SizedBox(width: 6),
          Expanded(
            child: AvailabilitySlot(
              hour: hours[i],
              isOn: controller.isSlotOn(hours[i]),
              onTap: () => controller.toggleSlot(hours[i]),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x332863F0),
                  blurRadius: 14,
                  offset: Offset(0, 6)),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Changes',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: TextButton.icon(
            onPressed: _confirmLogout,
            style: TextButton.styleFrom(
              backgroundColor: AppColors.redLight,
              foregroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.logout_rounded, size: 18),
            label: const Text('Logout',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }
}
