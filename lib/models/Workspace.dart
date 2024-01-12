/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Workspace type in your schema. */
class Workspace extends amplify_core.Model {
  static const classType = const _WorkspaceModelType();
  final String id;
  final String? _name;
  final bool? _active;
  final String? _inserted_at;
  final String? _updated_at;
  final User? _user;
  final List<Slot>? _slots;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  WorkspaceModelIdentifier get modelIdentifier {
      return WorkspaceModelIdentifier(
        id: id
      );
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool? get active {
    return _active;
  }
  
  String? get inserted_at {
    return _inserted_at;
  }
  
  String? get updated_at {
    return _updated_at;
  }
  
  User? get user {
    return _user;
  }
  
  List<Slot>? get slots {
    return _slots;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Workspace._internal({required this.id, required name, active, inserted_at, updated_at, user, slots, createdAt, updatedAt}): _name = name, _active = active, _inserted_at = inserted_at, _updated_at = updated_at, _user = user, _slots = slots, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Workspace({String? id, required String name, bool? active, String? inserted_at, String? updated_at, User? user, List<Slot>? slots}) {
    return Workspace._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      active: active,
      inserted_at: inserted_at,
      updated_at: updated_at,
      user: user,
      slots: slots != null ? List<Slot>.unmodifiable(slots) : slots);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Workspace &&
      id == other.id &&
      _name == other._name &&
      _active == other._active &&
      _inserted_at == other._inserted_at &&
      _updated_at == other._updated_at &&
      _user == other._user &&
      DeepCollectionEquality().equals(_slots, other._slots);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Workspace {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("active=" + (_active != null ? _active!.toString() : "null") + ", ");
    buffer.write("inserted_at=" + "$_inserted_at" + ", ");
    buffer.write("updated_at=" + "$_updated_at" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Workspace copyWith({String? name, bool? active, String? inserted_at, String? updated_at, User? user, List<Slot>? slots}) {
    return Workspace._internal(
      id: id,
      name: name ?? this.name,
      active: active ?? this.active,
      inserted_at: inserted_at ?? this.inserted_at,
      updated_at: updated_at ?? this.updated_at,
      user: user ?? this.user,
      slots: slots ?? this.slots);
  }
  
  Workspace copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<bool?>? active,
    ModelFieldValue<String?>? inserted_at,
    ModelFieldValue<String?>? updated_at,
    ModelFieldValue<User?>? user,
    ModelFieldValue<List<Slot>?>? slots
  }) {
    return Workspace._internal(
      id: id,
      name: name == null ? this.name : name.value,
      active: active == null ? this.active : active.value,
      inserted_at: inserted_at == null ? this.inserted_at : inserted_at.value,
      updated_at: updated_at == null ? this.updated_at : updated_at.value,
      user: user == null ? this.user : user.value,
      slots: slots == null ? this.slots : slots.value
    );
  }
  
  Workspace.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _active = json['active'],
      _inserted_at = json['inserted_at'],
      _updated_at = json['updated_at'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _slots = json['slots'] is List
        ? (json['slots'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Slot.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'active': _active, 'inserted_at': _inserted_at, 'updated_at': _updated_at, 'user': _user?.toJson(), 'slots': _slots?.map((Slot? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'active': _active,
    'inserted_at': _inserted_at,
    'updated_at': _updated_at,
    'user': _user,
    'slots': _slots,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<WorkspaceModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<WorkspaceModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final ACTIVE = amplify_core.QueryField(fieldName: "active");
  static final INSERTED_AT = amplify_core.QueryField(fieldName: "inserted_at");
  static final UPDATED_AT = amplify_core.QueryField(fieldName: "updated_at");
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final SLOTS = amplify_core.QueryField(
    fieldName: "slots",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Slot'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Workspace";
    modelSchemaDefinition.pluralName = "Workspaces";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Workspace.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Workspace.ACTIVE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Workspace.INSERTED_AT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Workspace.UPDATED_AT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Workspace.USER,
      isRequired: false,
      targetNames: ['userWorkspacesId'],
      ofModelName: 'User'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Workspace.SLOTS,
      isRequired: false,
      ofModelName: 'Slot',
      associatedKey: Slot.WORKSPACE
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _WorkspaceModelType extends amplify_core.ModelType<Workspace> {
  const _WorkspaceModelType();
  
  @override
  Workspace fromJson(Map<String, dynamic> jsonData) {
    return Workspace.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Workspace';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Workspace] in your schema.
 */
class WorkspaceModelIdentifier implements amplify_core.ModelIdentifier<Workspace> {
  final String id;

  /** Create an instance of WorkspaceModelIdentifier using [id] the primary key. */
  const WorkspaceModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'WorkspaceModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is WorkspaceModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}