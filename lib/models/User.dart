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


/** This is an auto generated class representing the User type in your schema. */
class User extends amplify_core.Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _name;
  final String? _inserted_at;
  final String? _updated_at;
  final List<Workspace>? _workspaces;
  final List<Slot>? _slots;
  final List<Item>? _items;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserModelIdentifier get modelIdentifier {
      return UserModelIdentifier(
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
  
  String? get inserted_at {
    return _inserted_at;
  }
  
  String? get updated_at {
    return _updated_at;
  }
  
  List<Workspace>? get workspaces {
    return _workspaces;
  }
  
  List<Slot>? get slots {
    return _slots;
  }
  
  List<Item>? get items {
    return _items;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, required name, inserted_at, updated_at, workspaces, slots, items, createdAt, updatedAt}): _name = name, _inserted_at = inserted_at, _updated_at = updated_at, _workspaces = workspaces, _slots = slots, _items = items, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, required String name, String? inserted_at, String? updated_at, List<Workspace>? workspaces, List<Slot>? slots, List<Item>? items}) {
    return User._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      inserted_at: inserted_at,
      updated_at: updated_at,
      workspaces: workspaces != null ? List<Workspace>.unmodifiable(workspaces) : workspaces,
      slots: slots != null ? List<Slot>.unmodifiable(slots) : slots,
      items: items != null ? List<Item>.unmodifiable(items) : items);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _name == other._name &&
      _inserted_at == other._inserted_at &&
      _updated_at == other._updated_at &&
      DeepCollectionEquality().equals(_workspaces, other._workspaces) &&
      DeepCollectionEquality().equals(_slots, other._slots) &&
      DeepCollectionEquality().equals(_items, other._items);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("inserted_at=" + "$_inserted_at" + ", ");
    buffer.write("updated_at=" + "$_updated_at" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? name, String? inserted_at, String? updated_at, List<Workspace>? workspaces, List<Slot>? slots, List<Item>? items}) {
    return User._internal(
      id: id,
      name: name ?? this.name,
      inserted_at: inserted_at ?? this.inserted_at,
      updated_at: updated_at ?? this.updated_at,
      workspaces: workspaces ?? this.workspaces,
      slots: slots ?? this.slots,
      items: items ?? this.items);
  }
  
  User copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<String?>? inserted_at,
    ModelFieldValue<String?>? updated_at,
    ModelFieldValue<List<Workspace>?>? workspaces,
    ModelFieldValue<List<Slot>?>? slots,
    ModelFieldValue<List<Item>?>? items
  }) {
    return User._internal(
      id: id,
      name: name == null ? this.name : name.value,
      inserted_at: inserted_at == null ? this.inserted_at : inserted_at.value,
      updated_at: updated_at == null ? this.updated_at : updated_at.value,
      workspaces: workspaces == null ? this.workspaces : workspaces.value,
      slots: slots == null ? this.slots : slots.value,
      items: items == null ? this.items : items.value
    );
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _inserted_at = json['inserted_at'],
      _updated_at = json['updated_at'],
      _workspaces = json['workspaces'] is List
        ? (json['workspaces'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Workspace.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _slots = json['slots'] is List
        ? (json['slots'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Slot.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _items = json['items'] is List
        ? (json['items'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Item.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'inserted_at': _inserted_at, 'updated_at': _updated_at, 'workspaces': _workspaces?.map((Workspace? e) => e?.toJson()).toList(), 'slots': _slots?.map((Slot? e) => e?.toJson()).toList(), 'items': _items?.map((Item? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'inserted_at': _inserted_at,
    'updated_at': _updated_at,
    'workspaces': _workspaces,
    'slots': _slots,
    'items': _items,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<UserModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UserModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final INSERTED_AT = amplify_core.QueryField(fieldName: "inserted_at");
  static final UPDATED_AT = amplify_core.QueryField(fieldName: "updated_at");
  static final WORKSPACES = amplify_core.QueryField(
    fieldName: "workspaces",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Workspace'));
  static final SLOTS = amplify_core.QueryField(
    fieldName: "slots",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Slot'));
  static final ITEMS = amplify_core.QueryField(
    fieldName: "items",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Item'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.INSERTED_AT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.UPDATED_AT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.WORKSPACES,
      isRequired: false,
      ofModelName: 'Workspace',
      associatedKey: Workspace.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.SLOTS,
      isRequired: false,
      ofModelName: 'Slot',
      associatedKey: Slot.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.ITEMS,
      isRequired: false,
      ofModelName: 'Item',
      associatedKey: Item.USER
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

class _UserModelType extends amplify_core.ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'User';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [User] in your schema.
 */
class UserModelIdentifier implements amplify_core.ModelIdentifier<User> {
  final String id;

  /** Create an instance of UserModelIdentifier using [id] the primary key. */
  const UserModelIdentifier({
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
  String toString() => 'UserModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}